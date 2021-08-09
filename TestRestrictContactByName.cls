@isTest
	private class TestRestrictContactByName {
    
    @isTest
    static void TestPositive(){
        
    Contact SingleTestPositiveContact= new Contact(FirstName='Lovely', LastName='InvalidName',Email='lovely@sunrise.com'); 
                                                
    //Action
    Test.startTest();
    Database.SaveResult result = Database.insert(SingleTestPositiveContact, false);
    Test.stopTest();
        
    //Assert
    
       System.assert(!result.isSuccess());
       System.assert(result.getErrors().size()>0);
       System.assertEquals('The Last Name "'+SingleTestPositiveContact.LastName+'" is not allowed for DML' ,
                           result.getErrors()[0].getMessage());
       system.debug(result.getErrors()[0].getMessage());
       }
        
    @isTest
    static void TestNegative(){
        
     Contact SingleTestNegativeContact= new Contact(FirstName='Lovely', LastName='InvalidName1', Email='lovely@sunrise.com');
        //Action
   		 Test.startTest();
   		 Database.SaveResult result = Database.insert(SingleTestNegativeContact, false);
    	 Test.stopTest();
        
    //Assert
    
       System.assert(result.isSuccess());
       System.assert(result.getErrors().size()==0);                
       system.debug('Successfully Inserted:'+result.getId());
    }
        
    @isTest
    static void TestforBulk(){
       
        List<Contact> TestContactList = new List<Contact>{
     
     	new Contact(FirstName='Happy', LastName='InvalidName', Email='happy@invalidname.com'),
        new Contact(FirstName='NotSoHappy', LastName='ValidName',Email='notsohappy@invalidname.com'),
        new Contact(Firstname='Fine', LastName='InvalidName1', Email='fine@Invalidname1.com'),
        new Contact(Firstname='Fine', LastName='FineLastName', Email='fine@finelastname.com')};
    
   	 //Action
   	 
    	Test.startTest();
    	Database.SaveResult[] result = Database.insert(TestContactList, false);
    	        Test.stopTest();
    
       // Iterate through each returned result
		for (Database.SaveResult sr :result) {
   		 if (sr.isSuccess()) {
        // Operation was successful, so get the ID of the record that was processed
        System.debug('Successfully inserted Contact. Contact ID: ' + sr.getId());
   	 }
    	else {
        // Operation failed, so get all errors                
        for(Database.Error err : sr.getErrors()) {
            System.debug('The following error has occurred.');                    
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
        }
        }
}

    }
        
     @isTest
     static void TestforUpdateContact(){
      
    
     Contact TestCon = new Contact(FirstName='Superb', Lastname='FineLastName', Email='superb@finelastname.com');
     insert TestCon;
     system.debug(TestCon.Id+':   '+TestCon.LastName);
     TestCon.LastName='InvalidName';
     
     //Action
     Test.startTest();
     Database.SaveResult result = Database.update(TestCon, false);
     Test.stopTest();

   	   System.assert(!result.isSuccess());
       System.assert(result.getErrors().size()>0);
       System.assertEquals('The Last Name "'+TestCon.LastName+'" is not allowed for DML' ,
                           result.getErrors()[0].getMessage());
       system.debug(result.getErrors()[0].getMessage());
    }
    }