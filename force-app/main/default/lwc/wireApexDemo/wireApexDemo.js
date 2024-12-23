import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class WireApexDemo extends LightningElement {

    @api recordId;
    contacts;
    error;

    @wire(getContacts, {accId: '$recordId'})
    //contacts;
    wiredContacts({error, data}){
        if(data){
            this.contacts = data;
            this.error = undefined;
        } else {
            this.contacts = undefined;
            this.error = error;
        }
    }
}