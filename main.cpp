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

// Helper functions for date calculation
std::string calculateStartDate(int period_days) {
    auto now = std::chrono::system_clock::now();
    auto start_tp = now - std::chrono::hours(24 * period_days);
    std::time_t start_time = std::chrono::system_clock::to_time_t(start_tp);

    std::tm tm_start;
    localtime_s(&tm_start, &start_time); // Use localtime_s for thread safety

    std::ostringstream os;
    os << std::put_time(&tm_start, "%Y-%m-%d");
    return os.str();
}

std::string getCurrentDate() {
    auto now = std::chrono::system_clock::now();
    std::time_t current_time = std::chrono::system_clock::to_time_t(now);

    std::tm tm_current;
    localtime_s(&tm_current, &current_time); // Use localtime_s for thread safety

    std::ostringstream os;
    os << std::put_time(&tm_current, "%Y-%m-%d");
    return os.str();
}

// cURL callback for fetching data
static size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* out) {
    size_t totalSize = size * nmemb;
    if (out) {
        out->append(static_cast<char*>(contents), totalSize);
        return totalSize;
    }
    return 0;
}

// Fetch data from the Polygon.io API
std::string fetchData(const std::string& url) {
    CURL* curl = curl_easy_init();
    std::string response_data;

    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response_data);

        CURLcode res = curl_easy_perform(curl);
        if (res != CURLE_OK) {
            std::cerr << "cURL Error: " << curl_easy_strerror(res) << std::endl;
        }
        curl_easy_cleanup(curl);
    }
    else {
        std::cerr << "Failed to initialize cURL!" << std::endl;
    }
    return response_data;
}

// Parse API response and extract data
bool parseData(const std::string& response_data, std::vector<double>& avgPrices, std::vector<double>& volumes) {
    Json::CharReaderBuilder builder;
    Json::Value root;
    std::string errors;

    std::istringstream iss(response_data);
    if (!Json::parseFromStream(builder, iss, &root, &errors)) {
        std::cerr << "JSON Parsing Error: " << errors << std::endl;
        return false;
    }

    // Check if the symbol exists in the response
    if (!root.isMember("ticker")) {
        std::cerr << "Error: Symbol not found in the API response." << std::endl;
        return false;
    }

    // Check if there are results in the response
    if (!root.isMember("results") || !root["results"].isArray()) {
        std::cerr << "Error: No data found in the API response." << std::endl;
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
double calculateAveragePrice(const std::vector<double>& avgPrices) {
    if (avgPrices.empty()) return 0.0;
    double total = tbb::parallel_reduce(
        tbb::blocked_range<size_t>(0, avgPrices.size()), 0.0,
        [&](const tbb::blocked_range<size_t>& r, double localSum) {
            for (size_t i = r.begin(); i < r.end(); ++i) {
                localSum += avgPrices[i];
            }
            return localSum;
        },
        std::plus<>()
    );
    return total / avgPrices.size();
}

// Compute total volume using TBB
double calculateTotalVolume(const std::vector<double>& volumes) {
    if (volumes.empty()) return 0.0;
    return tbb::parallel_reduce(
        tbb::blocked_range<size_t>(0, volumes.size()), 0.0,
        [&](const tbb::blocked_range<size_t>& r, double localSum) {
            for (size_t i = r.begin(); i < r.end(); ++i) {
                localSum += volumes[i];
            }
            return localSum;
        },
        std::plus<>()
    );
}
// find max/min Price using OpenMP
double findMaxPrice(const std::vector<double>& avgPrices) {
	double maxPrice = 0.0;
#pragma omp parallel for reduction(max:maxPrice)
	for (int i = 0; i < avgPrices.size(); ++i) {
		if (avgPrices[i] > maxPrice) {
			maxPrice = avgPrices[i];
		}
	}
	return maxPrice;
}
double findMinPrice(const std::vector<double>& avgPrices) {
	double minPrice = avgPrices[0];
#pragma omp parallel for reduction(min:minPrice)
	for (int i = 1; i < static_cast<int>(avgPrices.size()); ++i) {
		if (avgPrices[i] < minPrice) {
			minPrice = avgPrices[i];
		}
	}
	return minPrice;
}



// Find max/min volume using OpenMP
double findMaxVolume(const std::vector<double>& volumes) {
    double maxVolume = 0.0;
#pragma omp parallel for reduction(max:maxVolume)
    for (int i = 0; i < volumes.size(); ++i) {
        if (volumes[i] > maxVolume) {
            maxVolume = volumes[i];
        }
    }
    return maxVolume;
}

double findMinVolume(const std::vector<double>& volumes) {
    double minVolume = volumes[0];
#pragma omp parallel for reduction(min:minVolume)
    for (int i = 1; i < static_cast<int>(volumes.size()); ++i) {
        if (volumes[i] < minVolume) {
            minVolume = volumes[i];
        }
    }
    return minVolume;
}

// Main function
int main(int argc, char* argv[]) {


    MPI_Init(&argc, &argv);
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    std::vector<double> avgPrices, volumes;

	// setTicket and period_days default values
    std::string ticker = "AAPL";
    int period_days = 30;

	if (argc > 1) {
		ticker = argv[1];
	}
    if (argc > 2) {
        period_days = std::stoi(argv[2]);
    }




    std::string end_date = getCurrentDate();
    std::string start_date = calculateStartDate(period_days);
    std::string api_key = "eGcvQro193UaXcAZpT7tB8I0EoDN9Oey";

    std::string url = "https://api.polygon.io/v2/aggs/ticker/" + ticker +
        "/range/1/minute/" + start_date + "/" + end_date +
        "?adjusted=true&sort=asc&limit=50000&apiKey=" + api_key;

    std::string response_data = fetchData(url);
    parseData(response_data, avgPrices, volumes);
    if (!parseData(response_data, avgPrices, volumes)) {
        std::cerr << "Failed to parse data. Exiting." << std::endl;
        MPI_Abort(MPI_COMM_WORLD, EXIT_FAILURE);
    }

    if (rank == 0) {
        size_t chunkSize = avgPrices.size() / size;
        for (int dest = 1; dest < size; ++dest) {
            size_t start = dest * chunkSize;
            size_t end = (dest == size - 1) ? avgPrices.size() : start + chunkSize;
            int dataSize = static_cast<int>(end - start);
            MPI_Send(&dataSize, 1, MPI_INT, dest, 0, MPI_COMM_WORLD);
            MPI_Send(avgPrices.data() + start, dataSize, MPI_DOUBLE, dest, 1, MPI_COMM_WORLD);
            MPI_Send(volumes.data() + start, dataSize, MPI_DOUBLE, dest, 2, MPI_COMM_WORLD);
        }
        avgPrices.resize(chunkSize);
        volumes.resize(chunkSize);
    }
    else {
        int dataSize;
        MPI_Recv(&dataSize, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        avgPrices.resize(dataSize);
        volumes.resize(dataSize);
        MPI_Recv(avgPrices.data(), dataSize, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        MPI_Recv(volumes.data(), dataSize, MPI_DOUBLE, 0, 2, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    }

    double localAvgPrice = calculateAveragePrice(avgPrices);
    double localTotalVolume = calculateTotalVolume(volumes);
    double localMaxVolume = findMaxVolume(volumes);
    double localMinVolume = findMinVolume(volumes);
	double localMaxPrice = findMaxPrice(avgPrices);
	double localMinPrice = findMinPrice(avgPrices);

    double globalAvgPrice = 0.0;
    double globalTotalVolume = 0.0;
    double globalMaxVolume = 0.0;
    double globalMinVolume = 1e300;
	double globalMaxPrice = 0.0;
	double globalMinPrice = 1e300;

    MPI_Reduce(&localAvgPrice, &globalAvgPrice, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localTotalVolume, &globalTotalVolume, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localMaxVolume, &globalMaxVolume, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
    MPI_Reduce(&localMinVolume, &globalMinVolume, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);
	MPI_Reduce(&localMaxPrice, &globalMaxPrice, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
	MPI_Reduce(&localMinPrice, &globalMinPrice, 1, MPI_DOUBLE, MPI_MIN, 0, MPI_COMM_WORLD);


    if (rank == 0) {
        std::cout << std::fixed << std::setprecision(2); // Set fixed-point notation and 2 decimal places

        // Header
        std::cout << "================================\n";
        std::cout << "          Stock Analysis     \n";
        std::cout << "================================\n\n";

        // Symbol and Process Info
        std::cout << "Symbol:                "<< ticker <<"\n";
        std::cout << "Number of Processes:   " << size << "\n";
        std::cout << "Period:                " << period_days << " days\n";
        std::cout << "Start Date:            " << calculateStartDate(period_days) << "\n";
        std::cout << "End Date:              " << getCurrentDate() << "\n";
        std::cout << "Number of Records:     " << avgPrices.size() * size << "\n\n";

        // Price Summary
        globalAvgPrice /= size; // Finalize the average price
        std::cout << "Average Price:         $" << globalAvgPrice << "\n";
        std::cout << "Max Price:             $" << globalMaxPrice << "\n";
        std::cout << "Min Price:             $" << globalMinPrice << "\n\n";

        // Volume Summary
        std::cout << "Total Volume:          " << globalTotalVolume << "\n";
        std::cout << "Max Volume:            " << globalMaxVolume << "\n";
        std::cout << "Min Volume:            " << globalMinVolume << "\n";

        // Footer
        std::cout << "\n==============================\n";
        std::cout << "          End of Report     \n";
        std::cout << "================================\n";
    }


    MPI_Finalize();
    return 0;
}
