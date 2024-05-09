/**

    LOOPS
        - allow you to run the same code block over and over again
        - while
        - do-while
        - for
        - iteration for (enhanced for; for each)

 */


Integer age = 13;

while(age < 16) {
    System.debug('Too young to drive');
    age++;
}
System.debug(age + ' is old enough to drive');

// do-while always run at least once
do {

    System.debug('Too young to vote');
    age++;

} while(age < 18);
System.debug(age + ' is old enough to vote');


// FOR LOOPS
//      itr var ; condition ; change to itr var   
for(Integer i = 0; i < 10; i++) {

    System.debug('Happy ' + i + 'th birthday!');
}


// ITERATION FOR LOOPS
// for looping over collections

List<Integer> ages = new List<Integer>{17, 81, 32, 4, 24};

for(Integer i : ages) {
    if(i > 65) {
        System.debug(i + ' is Really really really old');
    }
    else if(i >= 21) {
        System.debug(i + ' is old enough to purchase alcohol');
    }
    else if(i >= 18) {
        System.debug(i + ' is old enough to vote');
    }
    else if(i >= 16) {
        System.debug(i + ' is old enough to get driver\'s license');
    }
    else {
        System.debug(i + ' is Really really really young');
    }
}