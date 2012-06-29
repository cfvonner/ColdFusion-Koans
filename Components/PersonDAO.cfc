<cfcomponent  displayname="PersonDAO" hint="I am the person DAO class." output="false">

	<cfproperty name="datasource" type="string" displayname="datasource" hint="I am the name of the datasource to use for persistence.">

	<cffunction name="init" 
			access="public" 
			output="false"
			hint="I am the constructor method for the PersonDAO class.">
		<cfargument name="datasource" required="true" type="string" hint="I am the name of the datasource to use in this class.">
		
		<!--- Store the properties --->
		<cfset variables.datasource = arguments.datasource>
		
		<!--- Return this object reference --->
		<cfreturn this>
	}
	</cffunction>
	
	<!--- Public Methods --->
	<cffunction name="getPersonByID"
			access="public"
			output="false"
			hint="I return a Person bean populated with the information for a specific person.">
		
		<cfargument name="personID"
				required="true"
				type="numeric"
				hint="I am the ID of the person you wish to retrieve.">
		
		<cfset var qSelect = ''>
		<cfset var objPerson = ''>
		
		<cfquery name="qSelect" datasource="#variables.datasource#">
			SELECT	Person_ID
					,firstName
					,lastName
					,dateOfBirth
			FROM	Persons
			WHERE	Person_ID = <cfqueryparam value="#arguments.personID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<!--- If qSelect returns a record matching the personID, create a Person bean and return it --->
		<cfif qSelect.RecordCount>
			<cfset objPerson = createObject("component","components.Person")
				.init(
					personID	= qSelect.Person_ID,
					firstName	= qSelect.firstName,
					lastName	= qSelect.lastName,
					dateOfBirth	= qSelect.dateOfBirth
				)>
		</cfif>
		
		<cfreturn objPerson>
	</cffunction>
	
	<cffunction name="deletePersonByID" 
				access="public" 
				output="false" 
				returntype="boolean" 
				hint="I delete a person from the database.">
				
		<cfargument name="personID" 
					required="true" 
					type="numeric"
					hint="I am the ID of the person 
	                   you wish to delete." >
					
			<cfset var qDelete = ''>
			<cfset var bSuccess = true>
			
				<cftry>
					<cfquery name="qDelete" datasource="#variables.datasource#">
						DELETE FROM Persons
						WHERE
							Person_ID = <cfqueryparam value="#arguments.personID#"
											cfsqltype="cf_sql_integer">
					</cfquery>
					
					<cfcatch type="database">
						<cfset bSuccess = false>
					</cfcatch>
				</cftry>
				
		<cfreturn bSuccess>
	</cffunction>
	
	<cffunction name="exists" 
				access="public" 
				output="false" 
				returntype="boolean" 
				hint="I check to see if a specific Person exists within 
						the database, using the personID as a check.">
						
		<cfargument name="person" 
					required="true" 
					type="components.Person" 
					hint="I am the Person bean.">
					
	    	<cfset var qExists = "">
	    	
		        <cfquery name="qExists" datasource="#variables.datasource#" maxrows="1">
		       		SELECT Person_ID
		       		FROM
						Persons
		       		WHERE 
						Person_ID = <cfqueryparam value="#arguments.person.getPersonID()#"
		               					cfsqltype="cf_sql_integer" />
		       	</cfquery>
				
		       <cfif qExists.recordCount>
		           <cfreturn true />
		       <cfelse>
		           <cfreturn false />
		       </cfif>		   
	</cffunction>

	<cffunction name="savePerson" 
				access="public" 
				output="false" 
				returntype="boolean" 
				hint="I handle saving a Person, either by creating 
						a new entry or updating an existing one.">
						
		<cfargument name="person" 
					required="true" 
					type="components.Person" 
					hint="I am the Person bean." />
					
	    	<cfset var bSuccess = '' />
	
	    	<cfif exists(arguments.person)>	
	        	<cfset bSuccess = updatePerson(arguments.person) />
	       	<cfelse>
	         	<cfset bSuccess = createPerson(arguments.person) />
	       	</cfif>
				
		<cfreturn bSuccess />
		
	</cffunction>

	<cffunction name="createPerson" 
			access="private" 
			output="false" 
			returntype="Numeric" 
			hint="I insert a new record into the persistence system (database).">
		
		<cfargument name="person" 
				required="true" 
				type="components.Person" 
				hint="I am the Person bean.">
		
		<cfset var qInsert = ''>
		<cfset var iResult = 0>
		
		<!--- Insert the property values from the person bean into the database --->
		<cfquery name="qInsert" datasource="#variables.datasource#" result="iResult">
			INSERT INTO Persons
			(
				firstName
				,lastName
				,dateofBirth
			)
			VALUES
			(
				<cfqueryparam value="#arguments.person.getFirstName()#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#arguments.person.getLastName()#" cfsqltype="cf_sql_varchar">
				,<cfqueryparam value="#arguments.person.getDateOfBirth()#" cfsqltype="cf_sql_date">   
			)
		</cfquery>
		
		<!--- Return the database-generated key value --->
		<cfreturn iResult.generatedKey>
		
	</cffunction>
	
	<cffunction name="updatePerson" 
			access="private" 
			output="false" 
			hint="I update a Persons information.">
			
		<cfargument name="person" 
					required="true" 
					type="components.Person" 
					hint="I am the Person bean.">
					
			<cfset var qUpdate = ''>
			<cfset var bSuccess	= true>
			
				<cftry>
				
					<cfquery name="qUpdate" datasource="#variables.datasource#">
						UPDATE	Persons
						SET	
							firstName		= <cfqueryparam value="#arguments.person.getFirstName()#" 
													cfsqltype="cf_sql_varchar">
							,lastName		= <cfqueryparam value="#arguments.person.getLastName()#"
													cfsqltype="cf_sql_varchar">
							,dateOfBirth	= <cfqueryparam value="#arguments.person.getDateOfBirth()#"
													cfsqltype="cf_sql_date">
						WHERE
							Person_ID = <cfqueryparam value="#arguments.person.getPersonID()#"
											cfsqltype="cf_sql_integer">
					</cfquery>
					
					<cfcatch type="database">
						<cfset bSuccess = false >
					</cfcatch>
				</cftry>
		<cfreturn bSuccess >
	</cffunction>
	
</cfcomponent>
