component displayname="Person" hint="I am a person object." output="false" accessors="true"   
{
	// Define the properties for this component
	property name="personID" type="numeric" getter="true" setter="false" hint="Unique numeric id assigned by the database.";
	property name="firstName" type="string" getter="true" setter="true" hint="The first name of the person.";
	property name="lastName" type="string" getter="true" setter="true" hint="The last name of the person.";
	property name="dateOfBirth" type="date" getter="true" setter="true" hint="The date of birth of the person.";
	
	// Define the functions other than implicit getters and setters for this component
	public any function init(
		required string firstName,
		required string lastName,
		required date dateOfBirth,
		numeric personID = 0
		) output="false" hint="I am the constructor method." {
			
			// Store the properties
			variables.personID = arguments.personID;
			this.setFirstName( arguments.firstName );
			this.setLastName( arguments.lastName );
			this.setDateOfBirth( arguments.dateOfBirth );
			
			// Return this object reference
			return( this );
		}   
	
	public string function getFullName() output="false" hint="I return the concatenation of firstName and lastName" {
		var FullName = getFirstName() & ' ' & getLastName();
		return FullName;
	}
}
