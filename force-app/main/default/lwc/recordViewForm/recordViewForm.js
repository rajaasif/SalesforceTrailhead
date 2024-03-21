import { LightningElement,api } from 'lwc';
// import CONTACT_OBJ from '@salesforce/schema/Contact';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
import PHONE from '@salesforce/schema/Contact.Phone';
import LEAD_SOURCE from '@salesforce/schema/Contact.LeadSource';

export default class RecordViewForm extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api fields = [FIRST_NAME,LAST_NAME,EMAIL,PHONE,LEAD_SOURCE];
}