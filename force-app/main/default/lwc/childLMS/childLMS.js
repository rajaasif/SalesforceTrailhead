import { LightningElement } from 'lwc';

export default class ChildLMS extends LightningElement {
    handleAddition(){
        this.dispatchEvent(new CustomEvent('addition'));
    }
    handleSubtraction(){
        this.dispatchEvent(new CustomEvent('subtraction'));
    }
    handleMultiplication(){
        this.dispatchEvent(new CustomEvent('multiplication', {detail:{value:10}}));
    }   
}