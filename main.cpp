#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <curl/curl.h>
#include <json/json.h>
#include <mpi.h>
#include <tbb/parallel_reduce.h>
#include <omp.h>
#include <tbb/blocked_range.h>
#include <chrono>
#include <iomanip>
#include <limits>
using namespace std; 

// Helper functions for date calculation
string calculateStartDate(int period_days) {
    auto now = chrono::system_clock::now();
    auto start_tp = now - chrono::hours(24 * period_days);
    time_t start_time = chrono::system_clock::to_time_t(start_tp);

    tm tm_start;
    localtime_s(&tm_start, &start_time); // Use localtime_s for thread safety

    ostringstream os;
    os << put_time(&tm_start, "%Y-%m-%d");
    return os.str();
}

string getCurrentDate() {
    auto now = chrono::system_clock::now();
    time_t current_time = chrono::system_clock::to_time_t(now);

    tm tm_current;
    localtime_s(&tm_current, &current_time); // Use localtime_s for thread safety

    ostringstream os;
    os << put_time(&tm_current, "%Y-%m-%d");
    return os.str();
}

// cURL callback for fetching data
static size_t WriteCallback(void* contents, size_t size, size_t nmemb, string* out) {
    size_t totalSize = size * nmemb;
    if (out) {
        out->append(static_cast<char*>(contents), totalSize);
        return totalSize;
    }
    return 0;
}

// Fetch data from the Polygon.io API
string fetchData(const string& url) {
    CURL* curl = curl_easy_init();
    string response_data;

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response_data);

        CURLcode res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            cerr << "cURL Error: " << curl_easy_strerror(res) << endl;
        }
        curl_easy_cleanup(curl);
    }
    else {
        cerr << "Failed to initialize cURL!" << endl;
    }
    return response_data;
}

// Parse API response and extract data
bool parseData(const string& response_data, vector<double>& avgPrices, vector<double>& volumes) {
    Json::CharReaderBuilder builder;
    Json::Value root;
    string errors;

    istringstream iss(response_data);
    if (!Json::parseFromStream(builder, iss, &root, &errors)) {
        cerr << "JSON Parsing Error: " << errors << endl;
        return false;
    }

    // Check if the symbol exists in the response
    if (!root.isMember("ticker")) {
        cerr << "Error: Symbol not found in the API response." << endl;
        return false;
    }

    // Check if there are results in the response
    if (!root.isMember("results") || !root["results"].isArray()) {
        cerr << "Error: No data found in the API response." << endl;
        return false;
    }

    // Parse results
    for (const auto& stick : root["results"]) {
        double open = stick["o"].asDouble();
        double high = stick["h"].asDouble();
        double low = stick["l"].asDouble();
        double close = stick["c"].asDouble();
        avgPrices.push_back((open + high + low + close) / 4.0);
        volumes.push_back(stick["v"].asDouble());
    }

    return true;
}

// Compute average price using TBB
double calculateAveragePrice(const vector<double>& avgPrices) {
    if (avgPrices.empty()) return 0.0;
    double total = tbb::parallel_reduce(
        tbb::blocked_range<size_t>(0, avgPrices.size()), 0.0,
        [&](const tbb::blocked_range<size_t>& r, double localSum) {
            // Use pointers for cache-friendly access
            const double* start = avgPrices.data() + r.begin();
            const double* end = avgPrices.data() + r.end();
            while (start < end) {
                localSum += *start++;
            }
            return localSum;
        },
        [](double x, double y) { return x + y; } 
    );
    return total / avgPrices.size();
}

// Compute total volume using TBB
double calculateTotalVolume(const vector<double>& volumes) {
    if (volumes.empty()) return 0.0;
    return tbb::parallel_reduce(
        tbb::blocked_range<size_t>(0, volumes.size()), 0.0,
        [&](const tbb::blocked_range<size_t>& r, double localSum) {
            const double* start = volumes.data() + r.begin();
            const double* end = volumes.data() + r.end();
            while (start < end) {
                localSum += *start++;
            }
            return localSum;
        },
        [](double x, double y) { return x + y; }
    );
}

// Find max price using OpenMP
double findMaxPrice(const vector<double>& avgPrices) {
    if (avgPrices.empty()) return numeric_limits<double>::lowest();
    double maxPrice = numeric_limits<double>::lowest();
#pragma omp parallel
    {
        double localMax = numeric_limits<double>::lowest();
#pragma omp for nowait
        for (int i = 0; i < static_cast<int>(avgPrices.size()); ++i) {
            localMax = max(localMax, avgPrices[i]);
        }
#pragma omp critical
        {
            maxPrice = max(maxPrice, localMax);
        }
    }
    return maxPrice;
}

// Find min price using OpenMP
double findMinPrice(const vector<double>& avgPrices) {
    if (avgPrices.empty()) return 1e300;
    double minPrice = 1e300;
#pragma omp parallel
    {
        double localMin = 1e300;
#pragma omp for nowait
        for (int i = 0; i < static_cast<int>(avgPrices.size()); ++i) {
            localMin = min(localMin, avgPrices[i]);
        }
#pragma omp critical
        {
            minPrice = min(minPrice, localMin);
        }
    }
    return minPrice;
}

// Find max volume using OpenMP
double findMaxVolume(const vector<double>& volumes) {
    if (volumes.empty()) return numeric_limits<double>::lowest();
    double maxVolume = numeric_limits<double>::lowest();
#pragma omp parallel
    {
        double localMax = numeric_limits<double>::lowest();
#pragma omp for nowait
        for (int i = 0; i < static_cast<int>(volumes.size()); ++i) {
            localMax = max(localMax, volumes[i]);
        }
#pragma omp critical
        {
            maxVolume = max(maxVolume, localMax);
        }
    }
    return maxVolume;
}

// Find min volume using OpenMP
double findMinVolume(const vector<double>& volumes) {
    if (volumes.empty()) return 1e300;
    double minVolume = 1e300;
#pragma omp parallel
    {
        double localMin = 1e300;
#pragma omp for nowait
        for (int i = 0; i < static_cast<int>(volumes.size()); ++i) {
            localMin = min(localMin, volumes[i]);
        }
#pragma omp critical
        {
            minVolume = min(minVolume, localMin);
        }
    }
    return minVolume;
}


int main(int argc, char* argv[]) {
    // Start the timer
    auto start = chrono::high_resolution_clock::now();

    // Initialize MPI
    MPI_Init(&argc, &argv);
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    vector<double> avgPrices, volumes;    // Stores prices and volumes globally
    vector<double> localAvgPrices, localVolumes; // Stores data locally for each process

    // Default arguments
    string ticker = "AAPL";
    int period_days = 30;

    if (argc > 1) {
        ticker = argv[1];
    }
    if (argc > 2) {
        period_days = stoi(argv[2]);
    }

    string end_date = getCurrentDate();
    string start_date = calculateStartDate(period_days);
    string api_key = "eGcvQro193UaXcAZpT7tB8I0EoDN9Oey";
    string url = "https://api.polygon.io/v2/aggs/ticker/" + ticker +
        "/range/1/minute/" + start_date + "/" + end_date +
        "?adjusted=true&sort=asc&limit=500000&apiKey=" + api_key;

    // Rank 0 fetches and distributes data
    vector<int> sendCounts(size), displs(size);
    if (rank == 0) {
        string response_data = fetchData(url);
        if (!parseData(response_data, avgPrices, volumes)) {
            cerr << "Failed to parse data. Exiting." << endl;
            MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
        }

        // Calculate chunk sizes and displacements
        size_t totalSize = avgPrices.size();
        size_t chunkSize = totalSize / size;
        size_t remainder = totalSize % size;

		// Calculate sendCounts and displacements for Scatterv
        for (int i = 0; i < size; ++i) {
			// Calculate the chunk sizes based on the total size and the number of processes if i is less than the remainder then sendCounts[i] = chunkSize + 1 else sendCounts[i] = chunkSize
            sendCounts[i] = chunkSize + (i < remainder ? 1 : 0);
			// Calculate displacements for Scatterv if i is 0 then displs[i] = 0 else displs[i] = displs[i-1] + sendCounts[i-1]
            displs[i] = (i == 0) ? 0 : displs[i - 1] + sendCounts[i - 1];
        }
    }

    // Broadcast sendCounts and displacements to all ranks
    int localSize;
	// Broadcast the size of the local data
    MPI_Scatter(sendCounts.data(), 1, MPI_INT, &localSize, 1, MPI_INT, 0, MPI_COMM_WORLD);
    localAvgPrices.resize(localSize);
    localVolumes.resize(localSize);

    // Scatter data
	// Scatterv is used to distribute the data based on the chunk sizes and displacements
	// MPI_Scatterv(const void *sendbuf, const int *sendcounts, const int *displs, MPI_Datatype sendtype, 
    MPI_Scatterv(avgPrices.data(), sendCounts.data(), displs.data(), MPI_DOUBLE,
        localAvgPrices.data(), localSize, MPI_DOUBLE, 0, MPI_COMM_WORLD);
    MPI_Scatterv(volumes.data(), sendCounts.data(), displs.data(), MPI_DOUBLE,
        localVolumes.data(), localSize, MPI_DOUBLE, 0, MPI_COMM_WORLD);

    // Perform local computation
    double localAvgPrice = calculateAveragePrice(localAvgPrices);
    double localTotalVolume = calculateTotalVolume(localVolumes);
    double localMaxVolume = findMaxVolume(localVolumes);
    double localMinVolume = findMinVolume(localVolumes);
    double localMaxPrice = findMaxPrice(localAvgPrices);
    double localMinPrice = findMinPrice(localAvgPrices);

    // Perform global reduction
    double globalAvgPrice, globalTotalVolume;
    double globalMaxVolume, globalMinVolume, globalMaxPrice, globalMinPrice;

    MPI_Reduce(&localAvgPrice, &globalAvgPrice, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localTotalVolume, &globalTotalVolume, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localMaxVolume, &globalMaxVolume, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localMinVolume, &globalMinVolume, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localMaxPrice, &globalMaxPrice, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localMinPrice, &globalMinPrice, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);

    // Rank 0 prints the results
    if (rank == 0) {
        globalAvgPrice /= size;

        cout << fixed << setprecision(2);
        cout << "================================\n";
        cout << "          Stock Analysis        \n";
        cout << "================================\n\n";
        cout << "Symbol:                " << ticker << "\n";
        cout << "Number of Processes:   " << size << "\n";
        cout << "Period:                " << period_days << " days\n";
        cout << "Start Date:            " << start_date << "\n";
        cout << "End Date:              " << end_date << "\n";
        cout << "Number of Records:     " << avgPrices.size() << "\n\n";
        cout << "Average Price:         $" << globalAvgPrice << "\n";
        cout << "Max Price:             $" << globalMaxPrice << "\n";
        cout << "Min Price:             $" << globalMinPrice << "\n\n";
        cout << "Total Volume:          " << globalTotalVolume << "\n";
        cout << "Max Volume:            " << globalMaxVolume << "\n";
        cout << "Min Volume:            " << globalMinVolume << "\n";
        cout << "\n==============================\n";
        cout << "          End of Report        \n";
        cout << "================================\n";

        auto end = chrono::high_resolution_clock::now();
        chrono::duration<double, milli> duration = end - start;
        cout << "Runtime: " << duration.count() << " ms" << endl;
    }

    MPI_Finalize();
    return 0;
}