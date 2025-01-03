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
	//Test for valid base GPIO peripheral register address
	GPIO_RegDef_t *TestAddr1 = NULL;
	GPIO_RegDef_t *TestAddr2 = (GPIO_RegDef_t*) 0x08000000U;
	GPIO_RegDef_t *TestAddr3 = GPIOA;	
	
	//Invalid, should make pointer NULL and return
	GPIO_Handle_t TestHandle;
	TestHandle.pGPIOx = TestAddr1;
	GPIO_Init(&TestHandle);
	POINTERS_EQUAL(NULL, TestHandle.pGPIOx);
	
	//Invalid, should make pointer NULL and return
	TestHandle.pGPIOx = TestAddr2;
	GPIO_Init(&TestHandle);
	POINTERS_EQUAL(NULL, TestHandle.pGPIOx);

	//Valid, no action taken and function should execute successfully
	TestHandle.pGPIOx = TestAddr3;
	GPIO_Init(&TestHandle);
	POINTERS_EQUAL(GPIOA, TestHandle.pGPIOx);
}