public with sharing class futureMethod {

    @future(callout=true)
    public static void sampleMethod(List<Id> recordIds){
        List<Account> listAccount = [select id, name from Account where id in :recordIds and industry = 'banking'];
        //process Records.
    }

    @future(callout=true)
    public static void sampleMethod2(){
        List<Account> listAccount = [select id, name from Account where industry = 'technology'];
        //process Records.
    }
}