trigger SendEmailToAdmin on Account (after insert) {

    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    User admin = [Select Id, name, email, profile.name from User where profile.name = 'System Administrator'][0];
    if(admin.email != null){

        for(Account a:trigger.new){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSenderDisplayName('Salesforce');
            mail.setUseSignature(false);
            mail.setBccSender(false);
            mail.setSaveAsActivity(false);
            mail.toAddresses = new String[]{admin.email};
            mail.setSubject('New Account is Created');
            mail.setHtmlBody('Dear Admin, A new account is created ' + a.Name);

            mails.add(mail);
        }

        if(mails.size() > 0){
            Messaging.sendEmailResult[] results = Messaging.sendEmail(mails);

            for(Integer i=0; i < results.size(); i++){
                if(results[i].success){
                    System.debug('The email is sent successfully');
                } else {
                    System.debug('Error sending Email - '+ results[i].Errors[0].message);
                }
            }
        }

    }
}