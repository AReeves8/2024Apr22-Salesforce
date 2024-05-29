

// Functions are first-class citizens in JS. You can both pass a fucntion into another function, and return a function from a function. 


function greeterGenerator(name) {


    /**
     * CLOSURE
     *      functions returned by functions have access to all variables in the outside lexical enviornment (in the original function)
     */

    return function() {
        console.log(`Hello, ${name}!`);
    }
}

const greetAlexander = greeterGenerator('Alexander');
greetAlexander();   
const greetJordan = greeterGenerator('Jordan');
greetJordan();

greeterGenerator('Bryan')();



/**
 * HIGHER ORDER FUNCTIONS (HOFs)
 *      any function that takes in a function OR returns a function
 * 
 *      arrays have tons of built in HOFs
 */

const fruits = ['strawberry', 'grapes', 'bananas', 'mangos', 'kiwis', 'pineapple', 'BLUEBERRY', 'rasPberry'];

// loops over each element in the array
fruits.forEach(function(fruitElement, index, copyOfFruits) {
    console.log(`Fruit at index ${index}: ${fruitElement}`);
});

// the above is kinda like this:
function forEach(array) {

    for(item in array) {
        indexCount = 0;
        return function(item, indexCount, array) {
            // doing something with the array
        }
        indexCount++;
    }
}

// change each item in the array in some way
const upperCasedFruits = fruits.map(function(fruitElement) {
    return fruitElement.toUpperCase();
});
console.log(fruits);                // original is always unchanged
console.log(upperCasedFruits);

// create a new array that only contains certain values from the orignal
const oopsAllBerries = fruits.filter(fruit => {         // if passing in EXACTLY one param, you don't need parenthesis on arrow function
    return fruit.toLowerCase().includes('berry');
});
console.log(fruits);                // original is always unchanged
console.log(oopsAllBerries);

// reducing an array to a single value
const numbers = [10, -20, 30, 8, 5];
const sum = numbers.reduce((prevValue, currValue) => {
    //same as: prevValue = prevValue + currValue
    return prevValue + currValue;
});

console.log(sum);


/**
 * CALLBACK FUNCTIONS
 *      functions that execute at a later point in time (whenever the developer calls the callback)
 *          don't have to be asynchronous. they can still run in the same thread
 * 
 *      common examples: setInterval and setTimeout
 *          asynchronous. uses multi-threading
 */

/**
 * setTimeout takes in a callBack function and a number of milliseconds to wait
 */
setTimeout(function() {
    console.log("It's been 3 seconds!");
}, 3000);

setTimeout(() => {                          // arrow function: shorthand for above. no change in functionality. 
    console.log("It's been 3 seconds!");
}, 3000);

// setInterval takes in a callback and a time. it calls the callback every interval of the given time
let count = 1;
const countdown = setInterval(() => {
    console.log(`It's been ${count} second(s)!`);
    if(count >= 10) {
        clearInterval(countdown);
    }
    count++;
}, 1000);



setTimeout(() => {                          
    console.log("It's been 0 seconds!");
}, 0);

console.log('AFTER 0 TIMEOUT!');    // actually runs before due to Event Loop priorities (lookup "Pyramid of Doom" for more examples)