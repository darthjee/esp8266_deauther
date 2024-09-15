#include "PowerController.h"

void PowerController::setup() {
    setupButtons();
}

void PowerController::setupButtons() {
    up   = new ButtonPullup(BUTTON_UP);
    down = new ButtonPullup(BUTTON_DOWN);
    a    = new ButtonPullup(BUTTON_A);
    b    = new ButtonPullup(BUTTON_B);
}
void PowerController::check(DisplayUI *display) {
  String msg = String(currentTime);

  display->showDebugMessage(msg);
}
