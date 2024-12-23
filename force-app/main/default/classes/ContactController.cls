public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        try {
            return[
                SELECT AccountId, Id, FirstName
                FROM Contact
                WHERE AccountId =: accId
                WITH security_enforced
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}