<cfscript>
	variables.myObj = createObject("component","Components.Person").init("Carl","Von Stetten",CreateDate(1972,8,14));
	/*myObj.setFirstName("Carl");
	myObj.setLastName("Von Stetten");
	myObj.setDateofBirth(CreateDate(1972,8,14));*/
	variables.myDAO = createObject("component","Components.PersonDAO").init("Koans");
	writeDump(variables.myDAO);
	variables.newRecordID = variables.myDAO.savePerson(variables.myObj);
	writeDump(variables.myObj.getFirstName());
	writeDump(variables.myObj.getFullName());
	writeDump(variables.myObj);
	writeDump(variables.newRecordID);
	writeDump(variables.myDAO.getPersonByID(1));
	variables.myObj2 = variables.myDAO.getPersonByID(2);
	variables.myObj2.setFirstName("Ethan");
	variables.myObj2.setDateOfBirth(CreateDate(1994,10,6));
	writeDump(variables.myDAO.savePerson(variables.myObj2));
	writeDump(variables.myDAO.deletePersonByID(4));
	writeDump(variables.myDAO.exists(variables.myObj2));
	variables.myObj3 = createObject("component","Components.Person").init("","",0,4);
	writeDump(variables.myDAO.exists(variables.myObj3));
</cfscript>

<!---<cfquery datasource="Koans">
	create table persons 
	(	person_ID int not null generated always as identity constraint persons_pk primary key,
		firstName varchar(50),
		lastName varchar(50),
		dateOfBirth date
	)
</cfquery>--->
<cfquery datasource="Koans" name="getPersons" >
	select *
	from Persons
</cfquery>

<cfdump var="#getPersons#">