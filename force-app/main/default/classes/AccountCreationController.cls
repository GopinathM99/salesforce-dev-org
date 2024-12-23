public with sharing class AccountCreationController {

    @AuraEnabled
    public static Account createAccount(Account acc){
        try {
            insert acc;
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}