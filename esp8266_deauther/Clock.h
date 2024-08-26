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
};