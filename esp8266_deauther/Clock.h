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
      CLOCK_MODE mode = CLOCK_MODE::REGULAR;
      const uint8_t *font = ArialMT_Plain_24;

      String clockString(int clockHour, int clockMinute);
      void setMode(CLOCK_MODE newMode);
    private:
      String regularClockString(int clockHour, int clockMinute);
      String randomClockString(int clockHour, int clockMinute);
      String formatTime(int time);
};
