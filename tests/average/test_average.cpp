#include "CppUTest/TestHarness.h"

extern "C" 
{
	#include "average.h"
}

TEST_GROUP(TestsAverage)
{
	void setup()
	{
		// Initialize before each test
			// eg, you need to allocate memory before tests begin
	}

	void teardown()
	{
		// Deinitialize after each test
			// eg, you need to free memory after tests end
	}
};

TEST(TestsAverage, Test1)
{
	float arr[] = {1.0,2.0,3.0};
	CHECK_EQUAL(2.0, Average(arr, sizeof(arr)/sizeof(arr[0])));
}