component extends="Koans.BaseKoan" {
	//stubbing
	public void function testSavingPerson()
	output=false hint=""{

		//create the mock of your dao
		var mockPersonDAO = mock("PersonDAO","typeSafe");
		//tell the mock that when save is called with the cut to return void
		mockPersonDAO.save(variables.Person).returns();
		//add it to the cut
		injectProperty(variables.person,'personDAO',mockPersonDAO);

		//now call the method to save
		variables.person.save(); //variables.person is your component under test (aka cut)

		mockPersonDAO.verify().save(variables.Person); //now all we have to do is make sure save was called properly
	}

	//mocking
	public void function testCheckingForUsernameExistanceDoesSomething()
	output=false hint=""{
		//create the mock of your dao
		var mockPersonDAO = mock("PersonDAO","typeSafe");
		//what we expect the method we are testing to return
		var expected = "Username does not already exist";
		//placeholder for actual
		var actual = "";

		//now we mock the behavior of the function, the known username foo returns false in this case
		mockPersonDAO.checkIfUsernameExists("foo").returns(false);

		//add it to the cut
		injectProperty(variables.person,'personDAO',mockPersonDAO);

		//now we setup the cut, in this case i'll call set username to foo, which
		//is the same string we told the dao to return "false" for
		variables.person.setUsername("foo");
		//set actual to the result of the method we are testing
		actual = variables.person.verifyUsername();
		//compare the results
		assertEquals(expected,actual,"Verify username with username that doesn't exist should return proper string");
	}
}
