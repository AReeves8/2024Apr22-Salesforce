

const createBoxButton = document.getElementById('create-box-button');
let boxCount = 0;

createBoxButton.addEventListener('click', () => {

    boxCount++;
    console.log('Create Box Button Clicked');

    const divElement = document.createElement('div');       // creating a new div element
    divElement.setAttribute('class', 'box');                // setting its class
    divElement.innerText = 'Box #' + boxCount;              // setting the inner text of the box

    document.getElementById('box-container').appendChild(divElement);   // adding div box as a child to the box container div

});


// DOMContentLoaded runs once the DOm is rendered for the first time
document.addEventListener('DOMContentLoaded', () => {
    getCatFactWithAsyncAwait();
});

document.getElementById('generate-fact').addEventListener('click', () => {
    getCatFact();
});




function getCatFact() {

    /**
     * PROMISE
     *      asynchronous objects that will return with data eventually
     *          chain .then() methods
     *          async/await
     * 
     *      promise states:
     *          pending - when the asynchronous operation is still ocurring
     *          resolved - the async operation completed successfully
     *          rejected - the async operation returned unsuccessfully
     *          settled - the async operation is completed and the callback is executed
     * 
     */

    fetch('https://cat-fact.herokuapp.com/facts/random?amount=1', { method : 'GET' })
        .then((response) => {
            // executed when the promise returns
            // whatever is returned by the promise will be passed in as a param

            // .then() handles resolved promises

            return response.json();     // this ALSO returns a promise
        })
        .then((jsonData) => {
            // how you manipulate the data DEPENDS on the structure of the data that is returned by the endpoint

            const catFactContainer = document.getElementById('fact-container');
            catFactContainer.innerText = jsonData.text;      // the endpoint sends back an object that contains a "text" property
        })
        .catch((error) => {

            // .catch() handles rejected promises

            console.error(error);
        })
}

async function getCatFactWithAsyncAwait() {

    /**
     * ASYNC/AWAIT
     *      await can only be used inside of async functions
     *          does the same thing as .then()
     *              EXCEPT: await pauses code execution, while .then() does not
     *      
     */

    try {

        // as long as all prmises are resolved, the code will continue as normal
        // rejected promises will throw an exception...

        const response = await fetch('https://cat-fact.herokuapp.com/facts/random?amount=1', { method : 'GET' });
        const jsonData = await response.json();

        const catFactContainer = document.getElementById('fact-container');
        catFactContainer.innerText = jsonData.text; 
    } catch(error) {
        // ...and be handled in the catch block
        console.error(error);
    }
}
