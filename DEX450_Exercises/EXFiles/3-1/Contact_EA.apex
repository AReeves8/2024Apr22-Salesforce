Contact contactToAdd = new Contact();
contactToAdd.firstName = 'June';
contactToAdd.lastName = 'Morgan';
insert contactToAdd;
System.debug('contactToAdd recordID is: ' + contactToAdd.id);
