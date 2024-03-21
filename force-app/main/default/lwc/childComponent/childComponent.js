import { LightningElement ,api} from 'lwc';

export default class ChildComponent extends LightningElement {
  @api  itemName = 'Hello World';
  @api handleclick(){
        this.itemName="Value changed while button clicked on parent component";
  }
}