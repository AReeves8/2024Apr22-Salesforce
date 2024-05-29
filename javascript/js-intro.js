// Java is to JavaScript the way a Car is to a Carpet


console.log('Hello World!');    // strings in js can be with single quotes or double quotes



/**
 * 3 different variable definitions
 *      var - function scoped, or global scoped (DON'T USE)
 *      let - block scope
 *      const - block scope, and its a constant
 */

var x = 20; // GLOBAL SCOPED to the file
console.log('BEFORE FUNCTION: ' + x);     // don't have to use semi-colons but YOU SHOULD!!!!


function myFunction(){
    
    console.log('FIRST IN FUNCTION: ' + x);         // undefined due to variable hoisting
    var x = 50;                                     // FUNCTION SCOPED to myFunction
    console.log('SECOND IN FUNCTION: ' + x);

    if(true) {

        var myVar = 'var Austin';       // FUNCTION SCOPED to myFunction
        let myLet = 'let Austin';       // BLOCK SCOPED to if statement

        console.log(myVar);
        console.log(myLet);
    }

    console.log(myVar);
    //console.log(myLet);     // ReferenceError: myLet is not defined 

}

myFunction();



/**
 * 
 * JS is not strongly typed, but it does have types
 *      primitive types:
 *          number (integers and floats)
 *          string (strings and chars)
 *          boolean
 *          undefined
 *          null
 *          BigInt (ex: 1n)
 *          Symbol (used as a JS identifier. Functions have a function Symbol so JS knows they're functions)
 *  
 *      non-primitive types:
 *          objects, arrays, functions, etc.
 */

let num1 = 1;
num1 = '1000';
console.log(num1 + ' typeof: ' + typeof num1);

num1 = Boolean(num1);   // will convert to a boolean
console.log(num1 + ' typeof: ' + typeof num1);

num1 = !!num1;          // will convert to a boolean
console.log(num1 + ' typeof: ' + typeof num1);


// TYPE COERCION
let myNum = 5;
let myNum2 = "10";

let sum1 = myNum + myNum2;      // here the string wins out, and myNum is coerced into a string
let dif1 = myNum - myNum2;      // here the number wins out, and myNum2 is coerced into a number
console.log('SUM1: ' + sum1);
console.log('DIF1: ' + dif1);


// TEMPLATE LITERALS
let name = 'Austin';

let newStr = 
`Here is a list of ${name}'s favorite foods: 
    1. French Fries
    2. Rice
    3. Steak
`;
console.log(newStr);


/**
 * TRUTHY vs FALSEY
 * 
 *  falsey:
 *      false
 *      0
 *      0n
 *      "" (empty strings)
 *      null
 *      undefined
 *      NaN (Not a Number. typeof NaN = number)
 *      
 *  truthy:
 *      "0" (any non-empty string)
 *          "false"
 *      {} (empty object)
 *      [] (empty array)
 *      - eveything else that isn't on the falsey list
 * 
 */

let someVal = [null];

if(someVal[0]) {
    console.log("It's truthy");     // someVal
}
else {
    console.log("It's falsey");     // someVal[0]
}


/**
 * Equality Operator (==)
 *      - checks values
 *  vs
 * Strict Equality Operator (===) 
 *      - checks types
 */

const num = 2;
const str = "2";
console.log(num == str);    // true
console.log(num === str);   // false

// strict equality can tell the difference bewteen null and undefined
console.log(null == undefined);    // true
console.log(null === undefined);   // false

// check that the array is not null AND not undefined
if(someVal != null) {
    // do something
}

// prevents null, undefined, and ALL falsey values
if(someVal) {
    // do something
}