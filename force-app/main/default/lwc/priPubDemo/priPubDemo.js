import { LightningElement, api } from 'lwc';

export default class PriPubDemo extends LightningElement {

    message = 'Private Property';
    @api recordId;
}