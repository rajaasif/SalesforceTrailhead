import { LightningElement,track ,wire} from 'lwc';
import getConList from '@salesforce/apex/getContactDetailsforWireDemo.getConList';
const columns=[
{label: "Name", fieldName: "FirstName"},
{label: "Contact ID", fieldName: "Id"},
];
export default class ParentComponent extends LightningElement {
            // @api demo
    handleclick(){
        this.template.querySelector("c-child-component").handleclick();
    }
                // @track demo
    @track fullName={firstName:"",lastName:""};
    handlechangeevent(event){
        const feild=event.target.name;
        if(feild == 'firstName'){
            this.fullName.firstName=event.target.value;
        }
        else{
            this.fullName.lastName=event.target.value;
        }
    }
                // @wire demo
    @track columns=columns;
    @track data=[];
    // @wire(getConList)
    //     getConListMethod({data,error}){
    //     if(data){
    //         this.data=data;
    //     }
    //     else if(error)
    //     window.alert('error occured');
    // }
    connectedCallback(){
        getConList().then(result =>{
            this.data=result;
        })
        .catch(error=>{
            console.log('error occured');
        })
    }
}