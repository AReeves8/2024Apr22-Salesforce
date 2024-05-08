import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import getCertsHeld from '@salesforce/apex/CertCheckerController.getCertsHeld';

export default class TechsCertsHeld extends LightningElement {
    @api recordId;
    cardTitle = 'Awaiting record ID';
    errorMessage;
    rowData = [];
    colData = [
               {label:'Technician', fieldName:'TechName', type:'text'},
               {label:'Certification', fieldName:'CertName', type:'text'},
               {label:'Date Achieved', fieldName:'DateAchieved', type:'date'}
              ];
	selectedRows = [];
	
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
	
    // Go get the Cert data for Techs belonging to the Account record
    @wire(getCertsHeld, {acctId: '$recordId'})
    getCertsHeldFunction (result) {
        this.rowData = [];
        if (result.data) {

            // Format records into a structure matching the column definitions for the table
            this.rowData = result.data.map(rec => ({
                Id: rec.Id,
                TechName: rec.Certified_Professional__r.Name,
                TechId: rec.Certified_Professional__c,
                CertName: rec.Certification__r.Name,
                CertId: rec.Certification__c,
                DateAchieved: rec.Date_Achieved__c
            }));
            this.errorMessage = null; // Clear any previous error
        } else if (result.error) {
            this.errorMessage = result.error.body.message;
        }
    }
	
    handleRowSelection(event) {
        let ids; // IDs of selected technicians

        // Identify the IDs of selected Technicians (if any)
        if (event.detail.selectedRows.length > 0) {
			this.selectedRows = event.detail.selectedRows;
            ids = this.selectedRows.map((r) => r.TechId);
        }

        // Create and dispatch a custom event
        const evt = new CustomEvent('selectedtechids', {
            detail: { techIds: ids }
        });
        this.dispatchEvent(evt);  
    }
}