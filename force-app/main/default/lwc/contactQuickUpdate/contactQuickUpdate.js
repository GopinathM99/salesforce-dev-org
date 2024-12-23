import { LightningElement,api, track } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import CONTACT_LASTNAME from '@salesforce/schema/Contact.LastName';
import CONTACT_EMAIL from '@salesforce/schema/Contact.Email';
import CONTACT_PHONE from '@salesforce/schema/Contact.Phone';
import CONTACT_ACCOUNT from '@salesforce/schema/Contact.AccountId';
import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class ContactQuickUpdate extends NavigationMixin(LightningElement) {

    @api recordId;
    objectApiName = CONTACT_OBJECT;
    fieldsList = [CONTACT_LASTNAME, CONTACT_PHONE, CONTACT_EMAIL, CONTACT_ACCOUNT];

    handleContactUpdate(event){
        const evt = new ShowToastEvent({
            title: 'Contact Updated',
            message: 'Contact ' + event.detail.fields.LastName.value + ' is updated successfully',
            variant: 'success'
        });
        this.dispatchEvent(evt);
    }
    
}