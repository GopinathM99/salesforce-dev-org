import { LightningElement } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_Type from '@salesforce/schema/Account.Type';
import Account_Industry from '@salesforce/schema/Account.Industry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateAccount extends NavigationMixin(LightningElement) {

    objectApiName = Account_Object;
    fieldsList = [Account_Name, Account_Type, Account_Industry];

    handleAccountCreate(event){
        const evt = new ShowToastEvent({ 
            title: 'Account Created',
            message: 'Record Id: ' + event.detail.id,
            variant: 'success'
         });
        this.dispatchEvent(evt);

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Account',
                actionName: 'view'
        }
        });
    }

}