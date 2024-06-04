import { LightningElement } from 'lwc';

export default class ObjectSelector extends LightningElement {

    objectSelected = false;             // to determine if the field selctor should be rendered or not
    selectedObject;                     // holds the selected object from the combobox
    objectsList = [                     // list of objects to use in the combobox
        {label : 'Account', value : 'Account'},
        {label : 'Contact', value : 'Contact'},
        {label : 'Lead', value : 'Lead'}
    ];

    // handles the onChange event from the combobox
    handleSelection(event) {
        this.objectSelected = true;
        this.selectedObject = event.detail.value;
        console.log(this.selectedObject);
    }

    handleFields(event) {
        console.log('FIELDS BEING HANDLED');
    }

}