trigger UpdateEmployeesFieldOnAccount on Account (before update) {

    //Usually we write trigger logic in handler but for this test writing logic in trigger itself.
    //Since we have to update the Employees field on the Contact itself we are using Before Update.

    if (trigger.isUpdate) {
        if (trigger.isBefore){

            Set<Id> accIds = new Set<Id>();
            Map<Id, Account> accountMap = new Map<Id, Account>();
        
            for(Account acc: trigger.new){
                accIds.add(acc.Id);
                accountMap.put(acc.Id, acc);
            }
        
            //Getting Count of Contacts for each Account.
            List<AggregateResult> results = [select AccountId, count(id) Total from Contact where AccountId in :accIds group by AccountId];
        
            for(AggregateResult ag: results){
        
                if(accountMap.containsKey((Id)ag.get('AccountId'))){
                    Account acc = accountMap.get((Id)ag.get('AccountId'));
                    acc.NumberOfEmployees = (integer)ag.get('Total');
                }
            } 
        

        }
    }
}

/*
Map<Id, Account> accMap = new Map<Id, Account>([select id, name, (select id, name from Opportunity) from Account]);

System.debug('Account - ' + accMap.get(acc.Id) + 'Opportunities Size - ' + acc.Opportunities.size())

*/