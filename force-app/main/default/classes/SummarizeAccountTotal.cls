public with sharing class SummarizeAccountTotal implements Database.Batchable<sObject>, Database.Stateful{

    public final String query;
    public Map<Id, Account> accountMap;

    public SummarizeAccountTotal() {
        accountMap = new Map<Id, Account>();
    }

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> scope){

        List<Opportunity> oppList = scope;

        for(Opportunity o: oppList){
            if(accountMap.containsKey(o.AccountId)){
                Account acc = accountMap.get(o.AccountId);
                acc.Test_Amount__c += o.Amount;
                accountMap.put(o.AccountId, acc);
            } else {
                accountMap.put(o.AccountId, new Account(Id = o.AccountId, Test_Amount__c = o.Amount));
            }
        }

    }

    public void finish(Database.BatchableContext bc){
        try{
            update accountMap.values();
        } catch(Exception e) {
            system.debug('Exception - ' + e.getMessage());
        }
    }

}