import { LightningElement } from 'lwc';

export default class ColorPicker extends LightningElement {
    colorCode;

    handleColorChange(event){
        const colorCodeValue = event.target.value;
        const evt = new CustomEvent('colorchange', {
            detail: {colorCodeValue}
        });
        this.dispatchEvent(evt);
        
    }
}