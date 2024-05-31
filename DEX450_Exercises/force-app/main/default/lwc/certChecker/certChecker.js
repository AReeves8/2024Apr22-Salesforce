import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class CertChecker extends LightningElement {

    @api
    recordId;
    cardTitle = 'Awaiting Record ID';
    techIds;

    @wire(getRecord, { recordId : '$recordId', fields : [ACCOUNT_NAME_FIELD]})
    wiredAccount(result) {
        if(result.data) {
            this.cardTitle = getFieldValue(result.data, ACCOUNT_NAME_FIELD) + ' Technicians';
        }
        else if(result.error) {
            this.cardTitle = 'Could not retreive account name with record id = ' + this.recordId;
        }   
    }


    handleSelectedTechIds(event){
        this.techIds = event.detail.techIds;
    }
}