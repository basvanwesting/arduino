#include "gmock/gmock.h"
#include "Sampler.h"

using namespace ::testing;
using namespace std;

TEST(SamplerTest, DynamicSizeOfSamples)
{
  Sampler sampler(1,4,8);
  EXPECT_EQ( sizeof(sampler.get_samples()), 8);
}

TEST(SamplerTest, AddOneSample)
{
  Sampler sampler(1,4,8);
  sampler.add_sample(100)
  EXPECT_EQ( sampler.get_samples()[0], 100);
}
