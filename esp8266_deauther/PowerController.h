#include "DisplayUI.h"

class PowerController {
  uint32_t actionTime;

    public:
        void check(DisplayUI *display);
        Button* up   = NULL;
        Button* down = NULL;
        Button* a    = NULL;
        Button* b    = NULL;
};
