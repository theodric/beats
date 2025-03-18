#include <stdio.h>
#include <time.h>

double get_beats(void) {
    time_t now;
    struct tm *utc_tm;
    
    // Get current UTC time
    time(&now);
    utc_tm = gmtime(&now);
    
    // Convert to UTC+1 (Biel time) by adding 1 hour
    int hours = utc_tm->tm_hour + 1;
    int minutes = utc_tm->tm_min;
    int seconds = utc_tm->tm_sec;
    
    // Handle day wrap
    if (hours >= 24) {
        hours -= 24;
    }
    
    // Calculate beats
    // One beat is 86.4 seconds (24 hours = 86400 seconds divided by 1000 beats)
    double seconds_since_midnight = (hours * 3600) + (minutes * 60) + seconds;
    double beats = seconds_since_midnight / 86.4;
    
    return beats;
}

int main(void) {
    printf("@%.3f\n", get_beats());
    return 0;
}
