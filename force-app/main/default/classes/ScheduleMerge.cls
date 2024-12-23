public with sharing class ScheduleMerge implements Schedulable{
    public void execute(SchedulableContext sc){
        MergeNumbers mN = new MergeNumbers();
    }
}

// ScheduleMerge m = new ScheduleMerge();
// String sch = '20 30 8 10 2 ?';
// String jobId = System.schedule('Merge Job', sch, m);
