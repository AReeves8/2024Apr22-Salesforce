import { createElement } from 'lwc';
import FieldSelector from 'c/fieldSelector';
import getObjectFields from '@salesforce/apex/DynamicObjectSearchController.getObjectFields';


/**
 * TESTING WIRE SERVICE
 *      - use mock data
 *          - "data" folder in __tests__
 *              - .json file with simulated data with same name as wire method
 *      - jest will use that mock data and simulate events with it
 *      - the goal is to test that your component is processing that data correctly
 *          - ex: if you're populating a table with returned data, you can test that the table's innerHTML has changed. 
 */
const mockGetObjectRecords = require("./data/getObjectFields.json");    // requiring that this test uses this data

// mock function to simulate the wire call to Apex
jest.mock(
    '@salesforce/apex/DynamicObjectSearchController.getObjectFields',   // import location for the Apex class being mocked
    () => {
        const { createApexTestWireAdapter } = require('@salesforce/sfdx-lwc-jest');
        return {
            default : createApexTestWireAdapter(jest.fn())  // jest.fn returns a blank mock function 
        };
    },
    // we are mocking a module that doesn't exist
    { virtual : true }
);



// describe - test suite. kinda like an apex test class. multiple per test file. 
describe('c-field-selector', () => {
    
    
    // after each test instance
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }

        // reset mock functions
        jest.clearAllMocks();
    });

    // "it" is a test function. can also be replaced with "test"
    it('will load data', () => {
        
        // adding the component to the DOM
        const element = createElement('c-field-selector', {
            is: FieldSelector
        });
        document.body.appendChild(element);


        /**
         * EXPECT functions (assertion methods)
         *      "matchers" instead of assertions
         * 
         *      .toBe() - checks strict equality (===)
         *      .toMatch() - if two strings are the same
         *      .toContain() - checks if a collection contains a value
         *      .toThrow() - throws an exception
         *      .not - inverses any other matcher
         */


        // Assert
        // const div = element.shadowRoot.querySelector('div');
        expect(1).toBe(1);
    });




    /**
     * MOCKS
     *      functions/data/properties/etc that are faking how they work
     * 
     *      jest tests do not run in your org. 
     *          - they do not have access to Apex. 
     *          - so we mock the data that is returned. 
     */

    test("getObjectFields sets dual listbox correctly", () => {

        // adding the component to the DOM
        const element = createElement('c-field-selector', {
            is: FieldSelector
        });
        document.body.appendChild(element);

        // call our mock function and have it emit mock data
        getObjectFields.emit(mockGetObjectRecords);     // calling the mock function created with jest.mock

        // simualting an asynchronous call with Promise.resolve()
        return Promise.resolve().then(() => {

            // retrieving the dual list box from shadow DOM
            const dualListBox = element.shadowRoot.querySelector('lightning-dual-listbox');

            const listBoxOptions = dualListBox.options;
            const optionsCount = dualListBox.options.length;

            expect(listBoxOptions).not.toBeNull();  // checking that options were set to *something*
            expect(optionsCount).toBe(3);           // checking that exactly 3 options were set
        });

    });





});