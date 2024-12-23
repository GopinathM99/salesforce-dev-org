public with sharing class scheduleExample implements Schedulable{
    
    public void execute(SchedulableContext sc){

        List<Contact> listContacts = [select id, name from Contact where CreatedDate = today limit 10];
        if(listContacts.size() > 0){
            delete listContacts;
        }

        BatchEx be1 = new BatchEx();
        Id id1 = Database.executeBatch(be1, 20);

        ChainApex2 ca1 = new ChainApex2();
        Id id2 = System.enqueueJob(ca1);

        futureMethod.sampleMethod2();

        // scheduleExample se1 = new scheduleExample();
        // Id id3 = system.schedule('First Schedule', ce, se1);
    }
}