public with sharing class batchAccountUpdate implements Database.Batchable<sObject>, Database.Stateful{

    Integer i = 10;
    
    public static Database.queryLocator start(Database.BatchableContext dbc){
        String query = 'select Id, name from Account limit 10';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext dbc, List<Account> scope){

        For(Account acc: scope){
            acc.name = ' Updated - ' + i ;
            i++;
        }

        update scope;

        
    }

    public void finish(Database.BatchableContext dbc){
        System.debug('Total Records - ' + i);
    }

    //Database.executeBatch(new batchAccountUpdate(), 4);
}