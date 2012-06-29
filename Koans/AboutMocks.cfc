/**
* @mxunit:decorators mxunit.framework.decorators.OrderedTestDecorator
*/
component extends="Koans.BaseKoan"{

	function testMyComponentInteractions()
	{
		// Our component under test (CUT)
		var myComponent = new Components.TestComponent();
		
		// Create the mock
		var mockSomeOtherComponent = mock();
		
		// Define the bahavior for our mock, including expected parameters
		mockSomeOtherComponent.doSomething( 'foo' ).returns( 123456 );
		
		// Inject this mock into CUT
		myComponent.setSomeOtherComponent( mockSomeOtherComponent );
		
		// Excercise CUT method (assume it relies on dependency of SomeOtherComponent)
		var actual = myComponent.myMethod( 'foo' );
		
		// Test assertion
		assertEquals( 'good stuff', actual );
	}	


}