trigger DupEmailPhone on Contact (before insert, before update) {

    if(trigger.isBefore){

        Map<String, Contact> emailMap = new Map<String, Contact>();
        Map<String, Contact> phoneMap = new Map<String, Contact>();

        for(Contact con: Trigger.new){
            if(trigger.isInsert){
                emailMap.put(con.email, con);
                phoneMap.put(con.phone, con);
                }
            if(trigger.isUpdate){
                if(trigger.oldMap.get(con.Id).email != con.email){
                    emailMap.put(con.email, con); 
                }
                if(trigger.oldMap.get(con.Id).phone != con.phone){
                    phoneMap.put(con.phone, con); 
                }
            }
        }

        String errorMessage;
        List<Contact> existingContactList = [select id, name, email, phone from contact where email in: emailMap.keySet() or phone in: phoneMap.keySet()];

        if(existingContactList.size() > 0){
            for(Contact con: existingContactList){
                if(con.email != null){
                    if(emailMap.get(con.email)){
                        errorMessage = 'Email Already Exists';
                    }
                }
                if(con.phone != null){
                    if(phoneMap.get(con.phone)){
                        errorMessage == ''? 'Phone Already Exists' errorMessage + ' and Phone Already Exists';
                    }
                }
                if(errorMessage != null){
                    trigger.new[0].addError('This Contact '+ errorMessage + 'already exists');
                }
                }
        }




    }
}