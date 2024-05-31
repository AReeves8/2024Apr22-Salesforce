import { LightningElement, api, wire } from 'lwc';
import getCertsHeld from '@salesforce/apex/CertCheckerController.getCertsHeld';
import deleteCertsHeld from '@salesforce/apex/CertCheckerController.deleteCertsHeld';
import { refreshApex } from '@salesforce/apex';


export default class TechsCertsHeld extends LightningElement {

    @api
    accRecordId;
    errorMessage;
    rowData = [];
    colData = [
        {label: 'Technician', fieldName: 'TechName', type: 'text'},
        {label: 'Certification', fieldName: 'CertName', type: 'text'},
        {label: 'Date Achieved', fieldName: 'DateAchieved', type: 'date'}
    ];
    selectedRows = [];
    disableDeleteBtn = true;
    wiredResult;

    @wire(getCertsHeld, { acctId : '$accRecordId' })
    wiredCertsHeld(result) {

        this.wiredResult = result; 

        if(result.data) {
            this.rowData = result.data.map((record) => ({
                Id : record.Id,
                TechName : record.Certified_Professional__r.Name,
                TechId: record.Certified_Professional__c,
                CertName: record.Certification__r.Name,
                CertId : record.Certification__c,
                DateAchieved : record.Date_Achieved__c
            }));

            //if we have a success, we want to ensure no errors are displayed
            this.errorMessage = null;
        }
        else if(result.error) {
            this.errorMessage = result.error.body.message;
        }
    }


    handleRowSelection(event) {

        let ids;

        if(event.detail.selectedRows.length > 0){
            this.selectedRows = event.detail.selectedRows;
            ids = this.selectedRows.map((row) => row.TechId);

            this.disableDeleteBtn = false;
        }
        else {
            this.disableDeleteBtn = true;
        }

        const evt = new CustomEvent('selectedtechids', {
            detail : {
                techIds : ids
            }
        });
        this.dispatchEvent(evt);
    }

    handleDeleteButton(event) {

        console.log('delete clicked');
        let ids = this.selectedRows.map((row) => row.Id);

        deleteCertsHeld({ certIds : ids })
            .then((result) => {
                refreshApex(this.wiredResult);
            })
            .catch((error)=> {
                this.errorMessage = error.body.message;
            });

    }
}
