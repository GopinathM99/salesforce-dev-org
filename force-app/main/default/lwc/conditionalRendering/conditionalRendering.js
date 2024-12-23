import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    areDetailsVisible;

    handleChange(event){
        this.areDetailsVisible = event.target.checked;
    }
}