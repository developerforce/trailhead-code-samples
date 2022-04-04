public with sharing class DisplayCaseController {

    @AuraEnabled
    public static Case getCaseFromId(Id caseID) {
        List<Case> cases = new List<Case>();
        
        if(caseID == null) {
            cases = [SELECT Id, Subject, Description, STATUS from Case LIMIT 1];
        } else {
            cases = [ SELECT Id, Subject, Description, Status from CASE where ID = :caseID ];
        }
        
        SObjectAccessDecision securityDecision = Security.stripInaccessible(
                                         AccessType.READABLE, cases);
        
        cases = securityDecision.getRecords();
        System.debug(cases);
        if(cases.size() == 0) {
            return null;
        } else {
            return cases[0];
        }        
    }
    
    
}
