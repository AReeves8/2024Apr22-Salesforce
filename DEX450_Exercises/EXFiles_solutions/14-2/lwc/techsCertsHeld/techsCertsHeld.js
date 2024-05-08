import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class TechsCertsHeld extends LightningElement {
    @api recordId;
    cardTitle = 'Awaiting record ID';
	
    // Get the Account name associated with the ID
    @wire(getRecord, { recordId: '$recordId', 
                       fields: [ACCOUNT_NAME_FIELD] })
    wiredAccount(result) {
        if (result.data) {
            this.cardTitle = getFieldValue(result.data, ACCOUNT_NAME_FIELD) + ' Technicians';
        }
        else if (result.error) {
            this.cardTitle = 'Could not retrieve Account name for ' + 'this record ID ' + this.recordId;
        }
    }
}