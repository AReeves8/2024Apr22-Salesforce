/**

    COLLECTIONS
        - to store multiple values in one variable
        - all are dynamic

        - List  (arrays do not exist in Apex)
        - Set
        - Map
 */


List<String> fruits = new List<String>();

// .add method to insert at the end of the list
fruits.add('banana');
fruits.add('grape');
fruits.add('orange');

// adding at a specifc index
fruits.add(1, 'strawberry');        // index locations start at 0
System.debug(fruits);

// retrieving at a specific index
System.debug(fruits.get(2));        
System.debug(fruits[2]);            // can use array notation

// gets the index of a specific value
System.debug('Index of banana: ' + fruits.indexOf('banana'));

// returns -1 if the value is not in the list
System.debug('Index of watermelon: ' + fruits.indexOf('watermelon'));

fruits.remove(2);
System.debug(fruits);

System.debug(fruits.size());

fruits[1] = 'watermelon';
System.debug(fruits);

//fruits[6] = 'kiwi';     // causes System.ListException: List index out of bounds: 6
System.debug(fruits);



// SETS
// they only store unique values
// not indexed

Set<String> names = new Set<String>();

names.add('Austin');
names.add('Wenshu');
names.add('Ed');
names.add('Emily');
names.add('Hassan');
names.add('Jordan');
names.add('Austin');        // won't be added (actually replaces the existing matching value)

System.debug(names);


// no .get - can use iteration for loop instead
for(String name : names) {
    System.debug(name);
}

// .addAll adds everything from a list
names.addAll(fruits);
System.debug(names);

// removes everything that isn't in the list
names.retainAll(fruits);    
System.debug(names);


// .removeAll that removes everything in the list
names.add('Austin');
names.add('Wenshu');
names.add('Ed');
names.add('Emily');
names.add('Hassan');
names.add('Jordan');
names.removeAll(fruits);    
System.debug(names);



// MAPS
// key-value pairs where keys are unique

Map<String, Integer> people = new Map<String, Integer>();

// .put to insert
people.put('Austin', 24);
people.put('Alexander', 23);
people.put('Miguel', 31);
people.put('Austin', 47);       // new value will OVERRIDE existing value at that key

System.debug(people);


// .get to retrieve the value at a key
System.debug('Miguel\'s age is ' + people.get('Miguel'));

// .keySet returns all keys as a set
Set<String> peoplesNames = people.keySet();
System.debug(peoplesNames.toString());

// .values returns a list of the values
List<Integer> peoplesAges = people.values();
System.debug(peoplesAges.toString());


