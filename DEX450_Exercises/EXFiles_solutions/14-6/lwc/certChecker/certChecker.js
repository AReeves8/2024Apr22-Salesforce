import { LightningElement, api } from 'lwc';

export default class CertChecker extends LightningElement {
	@api recordId;
    techIds; // IDs of selected technicians

    // Handle notification of selected technicians
    handleSelectedTechIds(event) {
        this.techIds = event.detail.techIds;
    }	
}