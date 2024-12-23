trigger UpdateClientOnAccount on Account (after insert) {

    List<Contact> contacts = new List<Contact>();
    List<Account> accountsToUpdate = new List<Account>();
    Set<Id> accIds = new Set<Id>();
    Map<Id, Account> accountMap = new Map<Id, Account>();

    for(Account a: trigger.new){
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName = a.Name;
        contacts.add(c);
        accIds.add(a.Id);
        accountMap.put(a.Id, a);
    }

    if(contacts.size() > 0){
        insert contacts;
    }

    if(contacts.size() > 0){
        for(Contact c: contacts){
            Account a = accountMap.get(c.AccountId);
            a.Client_Contact__c = c.Id;
            accountsToUpdate.add(a);  
        }
        
    }
    if(accountsToUpdate.size() > 0){
        update accountsToUpdate;
    }

}