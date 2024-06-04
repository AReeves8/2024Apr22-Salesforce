import { LightningElement, api, wire } from 'lwc';
import getObjectFields from '@salesforce/apex/DynamicObjectSearchController.getObjectFields';

export default class FieldSelector extends LightningElement {

    @api 
    objectToUse;                        // object that is passed in from objectSelector
    allFieldsList = [];                 // all posible fields shown to user
    selectedFieldsList = [];            // fields that have been slected by user
    errorMessage;                       // displays any errors to the user
    disableButton = true;               // toggle submit button on/off


    @wire(getObjectFields, {objectName : '$objectToUse'}) // ensuring the wire sevice is reactive to any changes to objectToUse with $
    wiredFieldResults(results) {
        if(results.data) {
            console.log(results.data);

            // formatting returned strings to fit the object needed for dual-listbox
            this.allFieldsList = results.data.map(element => ({
                label : element,
                value : element         // value is what's returned by event.detail.value
            })); 

            // ensure error message does not show up if fields are successfully returned
            this.errorMessage = null;
        }
        else if(results.error) {
            this.errorMessage = 'Fields could not be retrieved.';
        }
    }
    

    handleSelections(event) {

        // set all of the selceted fields
        this.selectedFieldsList = event.detail.value;

        // toggling submit button on when at least 1 field is selected
        if(this.selectedFieldsList.length > 0) {
            this.disableButton = false;     
        }
        else {
            this.disableButton = true;
        }
    }

    handleSubmit(event) {
        
        // prevents default click event action from running
        event.preventDefault();

        // create CustomEvent to be dispatched and then handled by the parent objectSelector
        const fieldSubmit = new CustomEvent('fieldsubmit', {
            detail : {
                selectedFields : this.selectedFieldsList
            } 
        });
        this.dispatchEvent(fieldSubmit);
    }
}