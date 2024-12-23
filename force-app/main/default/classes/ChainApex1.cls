public with sharing class ChainApex1 implements Queueable{
    
    public void execute(QueueableContext qc){
        List<Account> listAccountsToUpdate = new List<Account>();
        List<Account> listAccount = [select id, name, phone, description from Account where industry = 'banking' limit 100];

        for(Account acc: listAccount){
            acc.phone = '9392902';
            acc.description = 'From Queueable Apex Class';
            listAccountsToUpdate.add(acc);
        }
        if(listAccountsToUpdate.size() > 0){
            try{
                update listAccountsToUpdate;
            } catch(Exception e){
                system.debug('Exception Message - ' +e.getMessage());
            }
        }
    }
}