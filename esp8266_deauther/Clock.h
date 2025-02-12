#include "Arduino.h"
#include "src/esp8266-oled-ssd1306-4.1.0/OLEDDisplayFonts.h"

enum class CLOCK_MODE {
  REGULAR,
  CRYPTIC,
  PREDATOR,
  RANDOM,
  SET
};

class Clock {
  public:
    const uint8_t *font = ArialMT_Plain_24;
    int lastTime = -1;
    String lastTimeString;

    String clockString(char hour, char minute, char second);
    void setMode(CLOCK_MODE newMode);
  private:
    CLOCK_MODE mode = CLOCK_MODE::REGULAR;
    String regularClockString(char hour, char minute);
    String randomClockString(char hour, char minute);
    String numberToBitsString(char number, unsigned char tensColumns);
    String digitToBitsString(unsigned char digit, unsigned char columnsNumber);
    String columnsToString(unsigned char columns[3][3], unsigned char size);
    unsigned char columnToString(unsigned char *columns);
    String formatTime(unsigned char time);
};
