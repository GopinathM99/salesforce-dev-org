import { LightningElement } from 'lwc';

export default class RenderingListIterator extends LightningElement {

    contacts = [
        {
            Id: 1,
            Name: 'Sanjay Gupta',
            Title: 'Founder'
        }, 
        {
            Id: 2,
            Name: 'Banish K',
            Title: 'CEO'
        }, 
        {
            Id: 1,
            Name: 'Sandeep Shah',
            Title: 'Director'
        }
    ]
}