import { LightningElement, wire } from 'lwc';
import OBJECT_SEARCH_CHANNEL from '@salesforce/messageChannel/objectSearchChannel__c';
import { MessageContext, publish } from 'lightning/messageService';

export default class ObjectSelector extends LightningElement {

    objectSelected = false;             // to determine if the field selctor should be rendered or not
    selectedObject;                     // holds the selected object from the combobox
    objectsList = [                     // list of objects to use in the combobox
        {label : 'Account', value : 'Account'},
        {label : 'Contact', value : 'Contact'},
        {label : 'Lead', value : 'Lead'}
    ];

    @wire(MessageContext)
    messageContext;


    // handles the onChange event from the combobox
    handleSelection(event) {
        this.objectSelected = true;
        this.selectedObject = event.detail.value;
        console.log(this.selectedObject);
    }

    handleFields(event) {
        const payload = {
            object : this.selectedObject,
            fields : event.detail.selectedFields
        }

        console.log('PAYLOAD: ' + payload);

        // sending object and field data across the lightning message service
        publish(this.messageContext, OBJECT_SEARCH_CHANNEL, payload);
    }

}