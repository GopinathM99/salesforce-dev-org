import { api, LightningElement } from 'lwc';

export default class Child extends LightningElement {
    uppercasedName = 'default value';

    @api
    get itemName(){
        return this.uppercasedName;
    }
    set itemName(value){
        this.uppercasedName = value.toUpperCase();
    }
}