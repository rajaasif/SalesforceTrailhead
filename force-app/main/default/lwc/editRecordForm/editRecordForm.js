import { LightningElement,api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJ from '@salesforce/schema/Contact';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
import PHONE from '@salesforce/schema/Contact.Phone';
import LEAD_SOURCE from '@salesforce/schema/Contact.LeadSource';
export default class EditRecordForm extends LightningElement {
    @api recordId;
    @api objectApiName= CONTACT_OBJ;
    @api fields = [FIRST_NAME,LAST_NAME,EMAIL,PHONE,LEAD_SOURCE];
    @api successMessage = 'Record updated successfully';
    @api contactId="contact's ID"
    handleSubmit(event) {
       // event.preventDefault(); // Prevents the default form submission
    
        const fields = event.detail.fields;
    
    
      //  fields.Email='abc@gmail.com';
        if (fields.Phone=='') {
            fields.Phone = '0445364475';
        }
        this.template.querySelector("lightning-record-edit-form").submit(fields);
       
    }
    handleSuccess(event){
        this.contactId=event.detail.id;
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: this.successMessage,
            variant:'success'
        });
        this.dispatchEvent(toastEvent);
    }
    handleError(event){
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: event.detail.body.message,
            variant: 'error'
        });
        this.dispatchEvent(toastEvent);
    }
}