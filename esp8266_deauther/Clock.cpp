#include "Clock.h"

String Clock::formatTime(int time) {
    String clockTime = "";

    if (time < 10) clockTime += '0';
    clockTime += String(time);

    return clockTime;
}

String Clock::clockString(int clockHour, int clockMinute) {
  return regularClockString(clockHour, clockMinute);
}

String Clock::regularClockString(int clockHour, int clockMinute) {
  String clockTime = formatTime(clockHour);

  clockTime += ':';
  clockTime += formatTime(clockMinute);

  return clockTime;
}

String Clock::randomClockString(int clockHour, int clockMinute) {
  String clockTime = "5 365/45 427";

  return clockTime;
}
