import { LightningElement, track } from 'lwc';
import getConList from '@salesforce/apex/getContactDetailsforWireDemo.getConList';

export default class ComboBox extends LightningElement {
    @track value = '';
    @track options = [];

    connectedCallback() {
        this.loadOptions();
    }

    loadOptions() {
        getConList()
            .then(result => {
                
                let arr=[];
                for(var i=0;i<result.length;i++){
                    arr.push({label:result[i].FirstName,value:result[i].Id});
                }
                this.options = arr;
            })
            .catch(error => {
                console.error('Error occurred while fetching contacts:', error);
            });
    }

    handleChange(event) {
        this.value = event.detail.value;
        const selectedOption = this.options.find(option => option.value === this.value);
        this.name = selectedOption ? selectedOption.label : '';
    }
}
