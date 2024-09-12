#include "PowerController.h"

void PowerController::check(DisplayUI *display) {
  display->showDebugMessage(String(currentTime));
}
