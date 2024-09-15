#include "led.h"
#include "DisplayUI.h"

class PowerController {
    public:
        void setup();
        void check(DisplayUI *display);
    private:
        uint32_t actionTime;
        uint32_t timeout = 10;

        Button* up   = NULL;
        Button* down = NULL;
        Button* a    = NULL;
        Button* b    = NULL;

        void setupButtons();
};
