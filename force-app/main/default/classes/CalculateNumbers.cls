public with sharing class CalculateNumbers {

    @AuraEnabled
    public static integer addNumbers(integer fnumber, integer snumber){
        try {
            return (fnumber + snumber); 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}