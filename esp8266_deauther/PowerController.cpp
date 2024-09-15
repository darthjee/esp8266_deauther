#include "PowerController.h"

void PowerController::setup() {
    actionTime = currentTime;
    setupButtons();
}

void PowerController::setupButtons() {
    up   = new ButtonPullup(BUTTON_UP);
    down = new ButtonPullup(BUTTON_DOWN);
    a    = new ButtonPullup(BUTTON_A);
    b    = new ButtonPullup(BUTTON_B);

    up->setOnClicked([this]() {
        actionTime = currentTime;
    });

    down->setOnClicked([this]() {
        actionTime = currentTime;
    });

    a->setOnClicked([this]() {
        actionTime = currentTime;
    });

    b->setOnClicked([this]() {
        actionTime = currentTime;
    });
}
void PowerController::check(DisplayUI *display) {
    up->update();
    down->update();
    a->update();
    b->update();

    if (currentTime - actionTime >= timeout * 1000) {
      display->off();
      ESP.deepSleep(5000);
    }
}
