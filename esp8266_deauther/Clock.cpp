#include "Clock.h"

void Clock::setMode(CLOCK_MODE newMode) {
  mode = newMode;

  switch (mode) {
    case CLOCK_MODE::REGULAR:
    case CLOCK_MODE::SET:
      font = ArialMT_Plain_24; 
      break;

    case CLOCK_MODE::CRYPTIC:
      font = Cryptic_Plain_36;
      break;

    case CLOCK_MODE::PREDATOR:
      font = Predator_Plain_24;
      break;

    case CLOCK_MODE::RANDOM:
      font = Random_Plain_24;
      font = ArialMT_Plain_24; 
  }
}

String Clock::clockString(int clockHour, int clockMinute) {
  if (mode == CLOCK_MODE::RANDOM) {
    return randomClockString(clockHour, clockMinute);
  } else {
    return regularClockString(clockHour, clockMinute);
  }
}

String Clock::regularClockString(int clockHour, int clockMinute) {
  String clockTime = formatTime(clockHour);

  clockTime += ':';
  clockTime += formatTime(clockMinute);

  return clockTime;
}

String Clock::randomClockString(int clockHour, int clockMinute) {
//  String clockTime = "5 365/45 427";
  String clockTime = numberToBitsString(clockHour, (unsigned char) 1);

  return clockTime;
}

String Clock::numberToBitsString(int number, unsigned char tensColumns) {
  unsigned char tens = (unsigned char) (number / 10);
  unsigned char units = (unsigned char) (number % 10);

  return digitToBitsString(tens, tensColumns) + 
    " " +
    digitToBitsString(units, 3);
}

String Clock::digitToBitsString(unsigned char digit, unsigned char columnsNumber) {
  unsigned char columns[3] = {1,2,3};

  return columnsToString(columns, columnsNumber);
}

String Clock::columnsToString(unsigned char *columns, unsigned char size) {
  unsigned char i;
  String s = "";

  for (i = 0; i < size; i++) {
    s += columns[i];
  }
  return s;
}

String Clock::formatTime(int time) {
  String clockTime = "";

  if (time < 10) clockTime += '0';
  clockTime += String(time);

  return clockTime;
}
