public with sharing class AccountTriggerHandler_AC {
    public static void onAfterInsert(List<Account> newAccountList, Map<Id, Account> newAccountMap){
        Set<Id> accountIdSet = new Set<Id>();

        Id jobId;

        for(Account acc: newAccountList){
            accountIdSet.add(acc.Id);
        }
        //accountIdSet = newAccountList.keySet();


        if(accountIdSet.size() > 0) {
            jobId = System.enqueueJob(new AttachPDF_AC(accountIdSet));
        }
    }
}