import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {

    // greeting = 'Gopinath M';
    // fname;
    // lname;
    // uppercasedName;

    // handleChange(event){
    //     //this.greeting = event.target.value;

    //     if(event.target.name == 'fname'){
    //         this.fname = event.target.value;
    //     } else {
    //         this.lname == event.target.value;
    //     }
    // }

    // get uppercasedName(){
    //     return `{this.fname} {this.lname}`.toUpperCase();
    // }

    greeting = 'Gopinath M';
    fname;
    lname;

    handleClick(event){
        var input = this.template.querySelectorAll("lightning-input"); 

        input.forEach(function(element){
            if(element.name == 'fname'){
                this.fname = element.value; 
            } else if (element.name == 'lname'){
                this.lname = element.value;
            }
        }, this);
    }
}