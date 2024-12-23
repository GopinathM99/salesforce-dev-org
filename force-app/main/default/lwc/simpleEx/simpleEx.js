import { LightningElement, track,api, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import getAccountsRecordList from '@salesforce/apex/AccountController.getAccountsRecordsList';
import addNumbers from '@salesforce/apex/CalculateNumbers.addNumbers';

export default class SimpleEx extends LightningElement {
    fnumber = 0;
    snumber = 0;
    @track total;

    firstNumber = 0;
    secondNumber = 0;
    @track sum = 0;
    argError;

    data;
    error;
    columns = [
        {label: 'Label', fieldName: 'Name', type: 'text'},
        {label: 'Phone', fieldName: 'Phone', type: 'phone'},
        {label: 'Industry', fieldName: 'Industry', type: 'text'},
    ];

    accountRecords;
    imperativeError;

    connectedCallback(){
        getAccountsRecordList()
        .then((result) => 
            this.accountRecords = result)
        .catch((error)=> 
            this.imperativeError = error);
    }

    @wire(getAccounts) accountRecords({error,data}){
        if(data){
            this.data = data;
            this.error = undefined;
        } else if(error){
            this.error = error;
            this.data = undefined;
        }
    }

    handleChange(event){
        if(event.target.name == 'first'){
            this.fnumber = event.target.value;
        } else {
            this.snumber = event.target.value;
        }

        this.total = parseInt(this.fnumber) + parseInt(this.snumber);
    }

    handleInputChange(event){
        if(event.target.name == 'firstNumber'){
            this.firstNumber = event.target.value;
        } 
        if(event.target.name == 'secondNumber'){
            this.secondNumber = event.target.value;
        }
    }

    handleClick(event){
        addNumbers({fnumber: this.firstNumber, snumber: this.secondNumber})
            .then(result => this.sum = result)
            .catch(error => this.argError = error);
    }
}