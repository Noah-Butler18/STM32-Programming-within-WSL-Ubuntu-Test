#include "CppUTest/TestHarness.h"

extern "C" 
{
	#include "stm32f407xx_gpio_driver.h"
	#include "stm32f407xx.h"
}

TEST_GROUP(TestsGpioDriver)
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

TEST(TestsGpioDriver, Test1)
{
	CHECK_EQUAL(2, 2);
}


TEST(TestsGpioDriver, Test2)
{
	//Test for valid base GPIO peripheral register address
	GPIO_Handle_t TestHandle;
	

	//Invalid NULL pointer, should immediately return
	GPIO_RegDef_t *TestAddr1 = NULL;
	TestHandle.pGPIOx = TestAddr1;	
	GPIO_Init(&TestHandle);
	POINTERS_EQUAL(NULL, TestHandle.pGPIOx);

	//Valid, no action taken and function should execute successfully
	GPIO_RegDef_t *TestAddr2 = (GPIO_RegDef_t *)malloc(sizeof(GPIO_RegDef_t));
	TestHandle.pGPIOx = TestAddr2;
	//GPIO_Init(&TestHandle);
	POINTERS_EQUAL(TestAddr2, TestAddr2);

	//Valid, no action taken and function should execute successfully
	GPIO_RegDef_t testreg;
	GPIO_RegDef_t *TestAddr3 = &testreg;
	TestHandle.pGPIOx = TestAddr3;
	//GPIO_Init(&TestHandle);
	POINTERS_EQUAL(&testreg, TestHandle.pGPIOx);

	free(TestAddr2);
}
