#include "arduino.h"

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

      String clockString(int clockHour, int clockMinute);
    private:
      String regularClockString(int clockHour, int clockMinute);
      String randomClockString(int clockHour, int clockMinute);
      String formatTime(int time);
};
