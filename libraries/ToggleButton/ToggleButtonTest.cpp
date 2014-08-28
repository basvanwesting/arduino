#include "gmock/gmock.h"
#include "ToggleButton.h"

using namespace ::testing;
using namespace std;

TEST(ToggleButtonTest, InitiallyOff)
{
  ToggleButton onOffButton(5);
  EXPECT_EQ(onOffButton.isOn(),false);
}

TEST(ToggleButtonTest, OnAfterOneToggle) {
  ToggleButton onOffButton(5);
  onOffButton.toggle();
  EXPECT_EQ(onOffButton.isOn(),true);
}

TEST(ToggleButtonTest, OffAgainAfterTwoToggles) {
  ToggleButton onOffButton(5);
  onOffButton.toggle();
  onOffButton.toggle();
  EXPECT_EQ(onOffButton.isOn(),false);
}
