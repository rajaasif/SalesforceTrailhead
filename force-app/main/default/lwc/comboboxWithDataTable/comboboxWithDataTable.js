import { LightningElement,track } from 'lwc';
import getAccounts from '@salesforce/apex/getAccountsCombobox.getAccounts';
import getContactDetail from '@salesforce/apex/getAccountsCombobox.getContactDetail';
const columns=[{label:'Name',fieldName:'Name'},
               {label:'Id',fieldName:'Id'},];
export default class ComboboxWithDataTable extends LightningElement {

    @track value = '';
    @track options = [];
    cardVisible = false;
    @track data=[];
    columns=columns;
    connectedCallback() {
        getAccounts()
        .then(result => { 
            if(result){
                let arr=[];
                for(var i=0;i<result.length;i++){
                    arr.push({label:result[i].Name,value:result[i].Id});
                }
                this.options = arr;
            }
            else{
                this.options = [];
            }
         })
    }
    handleChange(event){
        this.cardVisible=true;
        this.value=event.detail.value;
        getContactDetail({accountID:this.value})
        .then(result=>{
            if(result){
                this.data=result;   
            }
            else{
                this.data=[];
            }
        })
    }

}