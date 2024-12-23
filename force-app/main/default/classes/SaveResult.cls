public with sharing class SaveResult {
    
    public static void saveMethod(){
        List<Account> accList = new List<Account>{new Account(name='Account One'), new Account()};

        Database.SaveResult[] results = Database.insert(accList, false);

        for(Database.SaveResult sr:results){
        
            if(sr.isSuccess()){
                System.debug('Account Inserted Successfully' + sr.getId());
            } else {
                for(Database.Error err: sr.getErrors()){
                    System.debug('Error Id' + err.getStatusCode() + ' Error Message - ' + err.getMessage());
                    System.debug('Error - ' + err.getFields());
                }
            }
        }
    }
}