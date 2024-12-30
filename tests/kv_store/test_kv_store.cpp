#include "CppUTest/TestHarness.h"

extern "C" 
{
	#include "kv_store.h"
}

// All tests must be part of a "test group"
// Create the test group
TEST_GROUP(FirstTestGroup)
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

// Test macros - used to make test cases
// Macros expect 2 parameters: Name of test group, name of individual test
TEST(FirstTestGroup, FirstTest)
{
	//make sure file is hooked up
	LONGS_EQUAL(true, kv_store_read(NULL, NULL, 0, NULL));
}


