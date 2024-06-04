import { LightningElement, wire } from 'lwc';
import OBJECT_SEARCH_CHANNEL from '@salesforce/messageChannel/objectSearchChannel__c';
import { MessageContext, subscribe } from 'lightning/messageService';
import getRecords from '@salesforce/apex/DynamicObjectSearchController.getRecords'

export default class SearchResults extends LightningElement {


    selectedObject;
    selectedFields;
    errorMessage;
    toggleTable = false;

    tableRowData = [];
    tableColData = [];

    subscription = null;

    @wire(MessageContext)
    messageContext;             // property containing context to lightning message service

    // calling an apex method to retrieve records from the org
    @wire(getRecords, {objectName : '$selectedObject', fieldNames : '$selectedFields'}) 
    wiredRecords(result) {
        if(result.data) {

            // setting the table data
            this.tableRowData = result.data;

            // ensuring the error message does not display
            this.errorMessage = null;
            this.toggleTable = true;
        }
        else if(result.error) {

            // setting the error message
            this.errorMessage = 'Data could not be retrieved.';
            this.toggleTable = false;
        }
    }

    // component lifecycle method that runs after the componet is rendered
    connectedCallback() {

        // setting this component to subscribe to the message channel as soon as it is loaded
        this.subscription = subscribe(
            this.messageContext,
            OBJECT_SEARCH_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        this.selectedObject = message.object;
        this.selectedFields = message.fields;

        console.log('OBJECT:' + this.selectedObject + '\nFIELDS: ' + this.selectedFields.toString());

        // setting columns with field data and formatting data to be used by lightning-datatable
        this.tableColData = this.selectedFields.map((element) => ({
            label : element,
            fieldName: element,
            type : 'text'
        }));
    }
}