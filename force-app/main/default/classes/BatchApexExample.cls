public with sharing class BatchApexExample implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'select id, name from Account';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Account> accList){
        for(Account acc: accList){
            acc.name = acc.name + ' sfdcPoint';
        }
        try {
            update accList;
        }
        catch(Exception e){
            System.debug(e);
        }
    }

    public void finish(Database.BatchableContext bc){
        // send email
    }
}


// BatchApexExample bae = new BatchApexExample();
// Id batchId = new Database.executeBatch(bae, 100);