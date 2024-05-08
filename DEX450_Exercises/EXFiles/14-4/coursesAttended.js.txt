import { LightningElement, api, wire } from 'lwc';
import getTechniciansAttendance from '@salesforce/apex/CertCheckerController.getTechniciansAttendance';

export default class CoursesAttended extends LightningElement {
    @api techIds;
    cardTitle = 'Courses Attended by Selected Technicians';
	errorMessage;

    // Row and column data for the lightning-datatable component
    rowData = [];
    colData = [
               {label: 'Technician', fieldName: 'TechName', type: 'text'},
               {label: 'Course', fieldName: 'CourseName', type: 'text'},
               {label: 'Date Attended', fieldName: 'DeliveryDate', type: 'date'},
              ];

    // Retrieve course attendance data for the input technicians
    @wire(getTechniciansAttendance, {techIds: '$techIds'})
    getTechniciansAttendanceFunction ({error, data}) {
        this.rowData = [];
        if (data) {
            
            // Format records into a structure matching the column definitions for the table
            this.rowData = data.map(rec => ({
                Id: rec.Id,
                TechName: rec.Student__r.Name,
                CourseName: rec.Course_Delivery__r.Course__r.Name,
                DeliveryDate: rec.Course_Delivery__r.Start_Date__c
            }));
            this.errorMessage = null; // Clear any previous error			
        } else if (error) {
            this.errorMessage = error.body.message;
        }
    }   
}