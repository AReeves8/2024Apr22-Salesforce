public with sharing class MassDeleteContacts_CX {

    public Integer numberRecords {get; private set;}
    public ApexPages.StandardSetController setCon {get; private set;}
    public List<Contact> contacts {get; private set;}
    public String errorMessage {get; private set;}

    public MassDeleteContacts_CX(ApexPages.StandardSetController stdSetController) {
        
        // Store the instance of the set controller and get the selected records
        setCon = stdSetController;
        List<Contact> selectedContacts = (List<Contact>)setCon.getSelected();
        numberRecords = selectedContacts.size(); 

        // The selected records only contain the ID field - if we want more need to run a query
        if (numberRecords > 0) {
            Set<Id> selectedIDs = new Set<Id>();
            for (Contact c : selectedContacts) {
                selectedIDs.add(c.Id);
            }
            contacts = [SELECT Id, Name FROM Contact WHERE Id IN :selectedIDs];
        }
    }    

    // Attempt a delete. Catch and report any errors returning to the same page
    public pageReference okDelete() {
    
        try {
            delete contacts;
            numberRecords = -1;
        }
        catch (Exception e) {
            numberRecords = -2;
            errorMessage = e.getMessage();
        }
        return null;
    }
    
    // Navigate back whence we came
    public pageReference okCancel() {
        return setCon.cancel();
    }    
}