/**
    BRANCHING
        - executing different branches of code based on some condition
        - if-else statements
        - switch statements
        - ternary operator (one-line if else) 

 */


// IF ELSE

Integer age = 6;

// logic is wrong! so reverse it
if(age >= 16) {
    System.debug('Old enough to get driver\'s license');
}
else if(age >= 18) {
    System.debug('Old enough to vote');
}
else if(age >= 21) {
    System.debug('Old enough to purchase alcohol');
}
else if(age >= 65) {
    System.debug('Old enough to retire');
}
else {
    System.debug('Really really really old');
}


if(age > 65) {
    System.debug('Really really really old');
}
else if(age >= 21) {
    System.debug('Old enough to purchase alcohol');
}
else if(age >= 18) {
    System.debug('Old enough to vote');
}
else if(age >= 16) {
    System.debug('Old enough to get driver\'s license');
}
else {
    System.debug('Really really really young');
}


// TERNARY OPERATOR
//               condition  ?           result if true              :     result if false
String message = (age >= 16 ? 'Old enough to get driver\'s license' : 'Really really really young');
System.debug(message);



// SWITCH STATEMENT

String day = 'SUNDAY';

switch on day {

    when 'MONDAY' {
        System.debug('You\'re just getting started');
    }
    when 'TUESDAY' {
        System.debug('One down, four to go');
    }
    when 'WEDNESDAY' {
        System.debug('You\'re halfway there');
    }
    when 'THURSDAY' {
        System.debug('Don\'t give up now!');
    }
    when 'FRIDAY' {
        System.debug('Almost!');
    }
    when 'SATURDAY', 'SUNDAY' {                 // can have multiple values
        System.debug('IT\'S THE WEEKEND!');
    }
}