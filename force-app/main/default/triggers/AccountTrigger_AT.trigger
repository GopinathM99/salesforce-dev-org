trigger AccountTrigger_AT on Account (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHandler_AC.onAfterInsert(Trigger.new, Trigger.newMap);
    }
}