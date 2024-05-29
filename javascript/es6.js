// JS is built on EcmaScript

/**
 * ES6 was addded in 2015
 *      - included tons of major changes to JS
 * 
 * ES7 came out in 2016, this is what LWCs use. 
 *      - a minor update from ES6. 
 */

// arrow functions
[1,2,3].map((item, index) => { 'Hello' });   // if its a one-liner, you don't need the "return" keyword


// using arrow functions to declare regular functions
function myFunc1() {

}
const myFunc2 = () => {

}

/**
 * OBJECTS
 *      key-value pairs
 *      kinda similar to python dictionaries
 */

// object literal syntax
const person = {
    age : 24,
    name : {
        firstName : 'Austin',
        lastName : 'Reeves'
    },
    faveColor : 'gray'
}
console.log(person.age);
console.log(person.name);
console.log(person.name.firstName);

// const is on the OBJECT, not its PROPERTIES
person.age = 45;
console.log(person.age);        // age is now 45

// can add new properties to objects
person.faveDayOfWeek = 'Saturday';
console.log(person);

const personJsonString = JSON.stringify(person);            // converts js object into JSON string. 
const parsedPersonObj = JSON.parse(personJsonString);       // converts JSON string to js object
console.log(personJsonString);
console.log(parsedPersonObj);

// will make the object read-only
Object.freeze(person);      

/* every property has values for enumerability, writablity, configurability

    object.freeze makes every property's writability false
    object.freeze makes the object configurability false


    Enumerable: you can enumerate over the properties when looping through object
    Writeable: if the values can be modified
    Configurable: if the data type can be changed. if the other properties (Enumerable and Writeable) can be changed.
        - as soon as this is set to false, it can't be configured back to true

*/
person.faveMovie = 'Avengers';
person.faveColor = 'blue';  
console.log(person);                // person object is unchanged

// copying object will copy the writability and configurability
const person2 = person;
person2.faveMovie = 'Avengers';
person2.faveColor = 'blue';  
console.log(person2);   

const animal = {
    species : 'dog',
    name : 'Ruby'
}

Object.defineProperty(animal, 'age', {enumerable : false, writable: false, configurable: true, value: 2.5});
console.log(animal);
animal.name = 'Penny';          // name is still writeable
animal.age = 7;                 // but age is not
console.log(animal);


/**
 * objects are ENUMERABLE not ITERABLE
 *                  in          on
 */
for(let property in person) {
    console.log(`Key: ${property}. Value: ${person[property]}` );       // square bracket notation to get the value at a specific property
}
for(let property in animal) {
    console.log(`Key: ${property}. Value: ${person[property]}` );       // age enumerability is false so it does not appear
}


// DESTRUCTURING

const animal2 = {
    species : 'dog',
    name : 'Ruby',
    age : 2
}
const {species, name} = animal2;        // taking each property in the object and moving them to their own variables
console.log('ANIMAL2 species: ' + species);


const nums = [1,2,3,4,5];
const [num1, num2, num3] = nums;
console.log('NUM1: ' + num1);

// skipping values
const [,,,num4] = nums;
console.log('NUM4: ' + num4);


/**
 * OPTIONAL CHAINING
 *      ?.
 *      same as apex safe navigation operator
 * 
 *      null check before moving on to the property
 */

animal2.home = {
    street : '123 Home Dr.',
    city : 'Dallas',
    state : 'Tx'
}

// instead of checking if an object or its properties are null
if(animal2.home == null) {
    console.log(animal2.home)
}

// you can just use optional chaining
console.log(animal2?.home?.city);


/**
 * NULLISH COALESCING OPERATOR
 *      return some default value if the variable is null
 * 
 *      ?? - if the variable is null, returns the following value
 */

let color = null;
let faveColor = color ?? 'blue';
console.log(faveColor);
