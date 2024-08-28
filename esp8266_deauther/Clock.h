#include "arduino.h"
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

    String clockString(int clockHour, int clockMinute);
    void setMode(CLOCK_MODE newMode);
  private:
    CLOCK_MODE mode = CLOCK_MODE::REGULAR;
    String regularClockString(int clockHour, int clockMinute);
    String randomClockString(int clockHour, int clockMinute);
    String numberToBitsString(int number, unsigned char tensColumns);
    String digitToBitsString(unsigned char digit, unsigned char columnsNumber);
    String columnsToString(unsigned char columns[], unsigned char size);
    String formatTime(int time);
};
