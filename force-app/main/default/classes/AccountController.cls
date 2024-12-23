public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        try {
            return [SELECT Id, Name, Phone, Industry 
                    FROM Account
                    LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account> getAccountsRecordsList(){
        try {
            return [SELECT Id, Name, Industry, Phone 
                    FROM Account
                    LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}