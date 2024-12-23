trigger OppoStageUpdate on Account (after update) {

    Set<Id> accountIds = new Set<Id>();

    for(Account acc: Trigger.New){
        accountIds.add(acc.Id);
    }

    DateTime day30 = system.now()-30;
    List<Opportunity> oppListToUpdate = new List<Opportunity>();

    List<Opportunity> oppList = [select id, AccountId, StageName, CloseDate from Opportunity where AccountId in :accountIds];

    if(oppList.size() > 0){
        for (Opportunity opp: oppList){
            if(opp.CloseDate < day30 && opp.StageName != 'Closed Won'){
                opp.StageName = 'Closed Lost';
                opp.CloseDate = system.today();
                oppListToUpdate.add(opp);
            }
        }
    }

    if(oppListToUpdate.size() > 0){
        update oppListToUpdate;
    }
}