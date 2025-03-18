#include <iostream>
#include <iomanip>
#include <chrono>
#include <ctime>
#include <windows.h>

class SwatchInternetTime {
private:
    static constexpr double BEATS_PER_DAY = 1000.0;
    static constexpr int SECONDS_PER_DAY = 86400;
    static constexpr int UTC_OFFSET = 3600; // UTC+1

public:
    static double getBeats() {
        // Get current UTC time using Windows API
        SYSTEMTIME utcTime;
        GetSystemTime(&utcTime); // Gets UTC time

        // Convert to UTC+1 (Biel time)
        SYSTEMTIME bielTime = utcTime;
        
        // Add one hour
        FILETIME ftUtc, ftBiel;
        SystemTimeToFileTime(&utcTime, &ftUtc);
        
        ULARGE_INTEGER uli;
        uli.LowPart = ftUtc.dwLowDateTime;
        uli.HighPart = ftUtc.dwHighDateTime;
        
        // Add 1 hour in 100-nanosecond intervals
        uli.QuadPart += 36000000000ULL; // 3600 seconds * 10000000 (100ns units)
        
        ftBiel.dwLowDateTime = uli.LowPart;
        ftBiel.dwHighDateTime = uli.HighPart;
        
        FileTimeToSystemTime(&ftBiel, &bielTime);

        // Calculate seconds since midnight
        int seconds = (bielTime.wHour * 3600) +
                     (bielTime.wMinute * 60) +
                     bielTime.wSecond;
        int milliseconds = bielTime.wMilliseconds;

        // Convert to beats (1 beat = 86.4 seconds)
        double beats = (seconds * 1000.0 + milliseconds) / 86400.0;
        
        return beats * BEATS_PER_DAY;
    }
};

int main() {
    // Set console output to UTF-8
    SetConsoleOutputCP(CP_UTF8);

    try {
        // Get beats
        double beats = SwatchInternetTime::getBeats();

        // Output with exactly 3 decimal places
        std::cout << '@' << std::fixed << std::setprecision(3) << beats << std::endl;

        return 0;
    }
    catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
}
