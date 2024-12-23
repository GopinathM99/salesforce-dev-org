trigger testing on Account (before update) {

    Set<Id> accIds = new Set<Id>();
    List<Account> accountsToUpdate = new List<Account>();
    Map<Id, Account> accountMap = new Map<Id, Account>();

    for(Account acc: trigger.new){
        accIds.add(acc.Id);
        accountMap.put(acc.Id, acc);
    }

    List<AggregateResult> results = [select AccountId, count(id) Total from Contact where AccountId in :accIds group by AccountId];

   /* for(AggregateResult ag: results){

        if(accountMap.containsKey((Id)ag.get('AccountId'))){
            Account acc = accountMap.get((Id)ag.get('AccountId'));
            acc.NumberOfEmployees = (integer)ag.get('Total');
            accountsToUpdate.add(acc);
        }
    } */ 

    
    List<Contact> contacts = [select AccountId, count(id) Total from Contact where AccountId in :accIds group by AccountId];

    for(Contact con: contacts){

        if(accountMap.containsKey(con.AccountId)){
            Account acc = accountMap.get(con.AccountId);
            acc.NumberOfEmployees = con.Total;
            accountsToUpdate.add(acc);
        }
    } 

    Database.SaveResult[] saveResults = Database.insert(accountsToUpdate, false);

    for(Database.SaveResult sr: saveResults){
        if(sr.isSuccess()){
            System.debug('Account Updated Successfully - ' + sr.getId() );
        } else {
            for(Database.Error err: sr.getErrors()){
                System.debug('Error Updating the Account: '+ err.getStatusCode() + '; Error Message - ' + err.getMessage());
            }
        }
    }
}