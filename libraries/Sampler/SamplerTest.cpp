#include "gmock/gmock.h"
#include "Sampler.h"

using namespace ::testing;
using namespace std;

TEST(SamplerTest, Constructor)
{
  Sampler sampler(5, 100);
  EXPECT_EQ( sampler.pin(), 5);
  EXPECT_EQ( sampler.frequency(), 100);
}

TEST(SamplerTest, interval_in_ms_round)
{
  Sampler sampler(0,100);
  EXPECT_THAT(sampler.interval_in_ms(), Eq(10));
}

TEST(SamplerTest, interval_in_ms_fraction)
{
  Sampler sampler(0,3);
  EXPECT_THAT(sampler.interval_in_ms(), Eq(333));
}

TEST(SamplerTest, delay_to_next_sample)
{
  Sampler sampler(0,100);
  int ms = sampler.delay_to_next_sample();
  EXPECT_THAT(ms, Lt(11));
  EXPECT_THAT(ms, Gt(9));
}

TEST(SamplerTest, duration_test)
{
  Sampler sampler(0,100);
  unsigned long start = millis();
  sampler.sample();
  sampler.sample();
  sampler.sample();
  sampler.sample();
  unsigned long end = millis();
  long duration = end - start;
  EXPECT_THAT(duration, Lt(45));
  EXPECT_THAT(duration, Gt(39));
}
