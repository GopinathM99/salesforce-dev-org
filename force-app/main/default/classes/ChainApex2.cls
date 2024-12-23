public with sharing class ChainApex2 implements Queueable{
    
    public void execute(QueueableContext qc){
        List<Account> listAccountsToUpdate = new List<Account>();
        List<Account> listAccount = [select id, name, fax, sic from Account limit 100];

        for(Account acc: listAccount){
            acc.fax = '9392902';
            acc.sic = qc.getJobId();
            listAccountsToUpdate.add(acc);
        }
        if(listAccountsToUpdate.size() > 0){
            try{
                update listAccountsToUpdate;
            } catch(Exception e){
                system.debug('Exception Message - ' +e.getMessage());
            }
        }

        Id jobId = system.enqueueJob(new ChainApex1());
    }
}