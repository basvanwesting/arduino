#include "gmock/gmock.h"
#include "ToggleButton.h"

using namespace ::testing;
using namespace std;

TEST(FirstTest, SimpleTrue) {
   ASSERT_TRUE(true);
}

TEST(SimplePinTest, trivial)
{
	EXPECT_EQ(1,1);
}

TEST(ToggleButtonTest, Toggle) {
  ToggleButton onOffButton(5);
  EXPECT_EQ(onOffButton.isOn(),false);
  onOffButton.toggle();
  EXPECT_EQ(onOffButton.isOn(),true);
  onOffButton.toggle();
  EXPECT_EQ(onOffButton.isOn(),false);
}

