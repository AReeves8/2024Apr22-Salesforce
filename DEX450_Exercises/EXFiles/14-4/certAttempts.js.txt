import { LightningElement, api, wire } from 'lwc';
import getTechniciansCertAttempts from '@salesforce/apex/CertCheckerController.getTechniciansCertAttempts';

export default class CertAttempts extends LightningElement {
    @api techIds;
    cardTitle = 'Certification Attempt Records for Selected Technicians';
	errorMessage;

    // Row and column data for the lightning-datatable component
    rowData = [];
    colData = [
               {label: 'Technician', fieldName: 'TechName', type: 'text'},
               {label: 'Certification', fieldName: 'CertName', type: 'text'},
               {label: 'Status', fieldName: 'Status', type: 'text'},
              ];

    // Retrieve certification attempt data for the input technicians
    @wire(getTechniciansCertAttempts, {techIds: '$techIds'})
    getTechniciansCertAttemptsFunction ({error, data}) {
        this.rowData = [];
        if (data) {
            
            // Format records into a structure matching the column definitions for the table
            this.rowData = data.map(rec => ({
                Id: rec.Id,
                TechName: rec.Certification_Candidate__r.Name,
                CertName: rec.Certification_Element__r.Certification__r.Name,
                Status: rec.Status__c
            }));
            this.errorMessage = null; // Clear any previous error
        } else if (error) {
            this.errorMessage = error.body.message;
        }
    }    
}