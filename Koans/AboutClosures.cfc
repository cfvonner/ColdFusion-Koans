/**
* @mxunit:decorators mxunit.framework.decorators.OrderedTestDecorator
*/
component extends="Koans.BaseKoan"{

	/**
	* @order 1
	*/
	public void function testWhatIsAClosure(){
		/* 
			In ColdFusion 10 we when a function executes, its internal variables are saved. When a
			variable is returned from a function, it can always access the variables that were defined
			in its scope.  This "enclosing" of a variables execution context variables is what a closure
			is.
		*/

		var actual = function(string appendMe){
			var myNewVar = "foo";

			return myNewVar & arguments.appendMe;
		}; 

		assertEquals(__,actual('bar'));
	}
}