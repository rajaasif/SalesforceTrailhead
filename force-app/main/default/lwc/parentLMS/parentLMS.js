import { LightningElement } from 'lwc';

export default class ParentLMS extends LightningElement {
    count=0;
    handleAdditon(){
        this.count++;
    }
    handleSubtraction(){
        this.count--;
    }
    handleMultiplication(event){
        this.count*=event.detail.value;
    }
}