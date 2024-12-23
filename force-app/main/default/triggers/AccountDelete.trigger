trigger AccountDelete on Account (before delete) {

    if(Trigger.isBefore && Trigger.isDelete){
        List<Account> accountsWithOpps = new List<Account>();
        accountsWithOpps = [select id, name, (select id, name from opportunities) from Account where id in:Trigger.Old];
    
        for(Account acc: accountsWithOpps){
            if(acc.opportunities.size() > 0){
                acc.Name.addError('You cannot delete accounts with related opptys' );
            }
        }
    }

}