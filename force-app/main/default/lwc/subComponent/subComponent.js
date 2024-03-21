import { LightningElement, wire } from 'lwc';
import { MessageContext, subscribe } from 'lightning/messageService';
import COUNTING_UPDATE from '@salesforce/messageChannel/Counting_Update__c';
export default class SubComponent extends LightningElement {
    count=0;
    // subscription=null;
    @wire(MessageContext) messageContext;
    connectedCallback(){
        this.subscription=subscribe(this.messageContext,COUNTING_UPDATE,(payload)=>this.handleCountUpdate(payload));
    }
    handleCountUpdate(payload){
        // const payload=event.data.payload;
        window.alert(JSON.stringify(payload));
        if(payload.operator=='addition'){
            this.count+=payload.constant;
        }
        else if(payload.operator=='subtraction'){
            this.count-=payload.constant;
        }
        else if(payload.operator=='multiplication'){
            this.count*=payload.constant;
        }
    }
}