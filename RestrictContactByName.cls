trigger RestrictContactByName on Contact (before insert, before update) {
	//check contacts prior to insert or update for invalid data
	For (Contact contactObj : Trigger.New) {
		//invalidname is invalid
		if(contactObj.LastName == 'INVALIDNAME') {
			contactObj.AddError('The Last Name "'+contactObj.LastName+'" is not allowed for DML');
		}
	}
}
