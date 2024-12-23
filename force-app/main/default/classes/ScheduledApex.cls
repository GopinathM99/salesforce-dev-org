public with sharing class ScheduledApex implements Schedulable{
    
    public static String cronExp = '0 0 0 3 9 ? 2044';

    public void execute(SchedulableContext sc){

        CronTrigger ct = [Select Id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where id =:sc.getTriggerId()][0];

        System.assertEquals(ct.CronExpression, ScheduledApex.cronExp);

    }
    //System.Schedule('First Batch', cronExp, new ScheduledApex());
}