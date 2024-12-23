import { LightningElement } from 'lwc';
import templateOne from './TemplateOne.html';
import templateTwo from './TemplateTwo.html';

export default class MulitpleTemplates extends LightningElement {

    templateOne = true;

    render(){
        return this.templateOne ? templateOne : templateTwo;
    }

    switchTemplate(event){
        this.templateOne = this.templateOne === true ? false : true;
    }
}