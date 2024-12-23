public with sharing class BatchEx implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext db){

        String str = 'Select id, name, email from Account limit 1000';
        return Database.getQueryLocator(str);
    }

    public void execute(Database.BatchableContext db, List<Account> listAccounts){
        List<Account> listAccountsToUpdate = new List<Account>();
        for(Account acc: listAccounts){
            acc.name = acc.name + ' from Apex';
            listAccountsToUpdate.add(acc);
        }

        if(listAccountsToUpdate.size() > 0){
            try{
                update listAccountsToUpdate;
            }
            catch(Exception e) {
                System.debug('Update failed. Exception ' + e.getMessage());
            }
        }
    }

    public void finish(Database.BatchableContext bc){
        //send Email
        system.debug('Batch Job Completed');
    }
}