trigger TotalAmountOfRelatedOpps on Account (before update) {

    Set<Id> accountIds = new Set<Id>();

    for(Account a: trigger.new){
        accountIds.add(a.Id);
    }

    Map<Id, Double> accMap = new Map<Id, Double>();
    List<AggregateResult> results = [select AccountId, sum(amount) TotalAmount from Opportunity where AccountId in :accountIds group by AccountId];

    if(results.size() > 0){
        for(AggregateResult ar: results){
            Id accId = (Id)ar.get('AccountId');
            Double accTotal = (Double)ar.get('TotalAmount');
            accMap.put(accId,accTotal);
        }
    
        for(Account a: trigger.new){
            if(accMap.containsKey(a.Id)){
                a.Test_Amount__c = accMap.get(a.Id); 
            }
        }
    }

}