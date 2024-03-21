import { LightningElement } from 'lwc'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class App extends LightningElement { 
  message = 'Hello World';
  handleclick(){
    this.showToast();
    
  } 
 
  showToast(){
    const evnt= new ShowToastEvent({
        title: 'This is sa toast',
        message: 'Salesforce documentation is available in the app',
        variant: 'success'
    });
    this.dispatchEvent(evnt);
  }
  connectedCallback(){
    
  }
}
