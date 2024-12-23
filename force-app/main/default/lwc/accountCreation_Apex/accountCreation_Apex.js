import { LightningElement, track } from 'lwc';
import createAccount from '@salesforce/apex/AccountCreationController.createAccount';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_TYPE from '@salesforce/schema/Account.Type';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class AccountCreation_Apex extends LightningElement {
    
    @track accountId;
    @track error;
    @track accountRecord = {
        Name: ACCOUNT_NAME,
        Type: ACCOUNT_TYPE,
        Phone: ACCOUNT_PHONE
    }

    handleChange(event){
        if(event.target.label == 'Account Name'){
            this.accountRecord.Name = event.target.value;
        } else if(event.target.label == 'Account Type') {
            this.accountRecord.Type = event.target.value;
        } else if (event.target.label == 'Account Phone') {
            this.accountRecord.Phone = event.target.value;
        }
    }

    handleSaveAccount(event){
        console.log('inside handle save');
        createAccount({acc:this.accountRecord})
        .then(account => {
            this.accountRecord = {};
            const toastEvent = new ShowToastEvent({
                title: 'Account Created',
                message: 'Account Successufully Created',
                variant: 'success'
            });
            this.dispatchEvent(toastEvent);
        })
        .catch(error => {
            this.error = error.message;
        })
    }

}