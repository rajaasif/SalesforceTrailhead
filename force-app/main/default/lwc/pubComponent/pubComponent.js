import { LightningElement, wire} from 'lwc';
import {publish,MessageContext} from 'lightning/messageService';
import COUNTING_UPDATE from '@salesforce/messageChannel/Counting_Update__c';
export default class PubComponent extends LightningElement {
    @wire(MessageContext) messageContext;
    handleIncrement(){
        const payload={
            operator:'addition',
            constant: 10
        }
        publish(this.messageContext,COUNTING_UPDATE,payload);
    }
    handleDecrement(){
        const payload={
            operator:'subtraction',
            constant: 10
        }
        publish(this.messageContext,COUNTING_UPDATE,payload);
    }
    handleMultiplication(){11
        const payload={
            operator:'multiplication',
            constant: 2
        }
        publish(this.messageContext,COUNTING_UPDATE,payload);
    }

}