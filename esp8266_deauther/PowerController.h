#include "DisplayUI.h"

class PowerController {
    public:
        void setupButtons();
        void setup();
        void check(DisplayUI *display);
    private:
        uint32_t actionTime;

        Button* up   = NULL;
        Button* down = NULL;
        Button* a    = NULL;
        Button* b    = NULL;
};
