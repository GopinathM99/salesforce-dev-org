import { LightningElement,api } from 'lwc';

export default class SecondPage extends LightningElement {
    @api greeting = 'Welcome to Dublin';
    @api name = 'Gopinath';
}