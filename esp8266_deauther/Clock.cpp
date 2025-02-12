#include "Clock.h"

void Clock::setMode(CLOCK_MODE newMode) {
  mode = newMode;
  lastTime = -1;

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
  }
}

String Clock::clockString(char hour, char minute, char second) {
  int currentTime = hour * 3600 + minute * 60 + second;
  int diff = currentTime - lastTime;

  if (lastTime <= 0 || diff > 2 || diff < 0) {
    if (mode == CLOCK_MODE::RANDOM) {
      lastTimeString = randomClockString(hour, minute);
    } else {
      lastTimeString = regularClockString(hour, minute);
    }
    lastTime = currentTime;
  }
  
  return lastTimeString;
}

String Clock::regularClockString(char hour, char minute) {
  String clockTime = formatTime(hour);

  clockTime += ':';
  clockTime += formatTime(minute);

  return clockTime;
}

String Clock::randomClockString(char hour, char minute) {
  String clockTime = numberToBitsString(hour, (unsigned char) 1);

  clockTime += "/";
  clockTime += numberToBitsString(minute, (unsigned char) 2);

  return clockTime;
}

String Clock::numberToBitsString(char number, unsigned char tensColumns) {
  unsigned char tens = (unsigned char) (number / 10);
  unsigned char units = (unsigned char) (number % 10);

  return digitToBitsString(tens, tensColumns) + 
    " " +
    digitToBitsString(units, 3);
}

String Clock::digitToBitsString(unsigned char digit, unsigned char columnsNumber) {
  unsigned char max = columnsNumber * 3;
  unsigned char half = max / 2;
  unsigned char deft = digit > half ? 1 : 0;
  unsigned char bit = digit > half ? 0 : 1;
  unsigned char value = digit > half ? max - digit : digit;
  unsigned char columns[3][3] = {
    {deft, deft, deft},{deft, deft, deft},{deft,deft,deft}
  };
  unsigned char col, row;

  while (value > 0) {
    col = rand() % columnsNumber;
    row = rand() % 3;

    if (columns[col][row] == deft) {
      columns[col][row] = bit;
      value--;
    }
  }

  return columnsToString(columns, columnsNumber);
}

String Clock::columnsToString(unsigned char columns[3][3], unsigned char size) {
  unsigned char i;
  String s = "";

  for (i = 0; i < size; i++) {
    s += columnToString(columns[i]);
  }
  return s;
}

unsigned char Clock::columnToString(unsigned char *column) {
  unsigned char i;
  unsigned char value = 0;
  unsigned char power = 1;

  for (i = 0; i < 3; i++) {
    value += power * column[i];
    power *= 2;
  }

  return value;
}

String Clock::formatTime(unsigned char time) {
  String clockTime = "";

  if (time < 10) clockTime += '0';
  clockTime += String(time);

  return clockTime;
}
