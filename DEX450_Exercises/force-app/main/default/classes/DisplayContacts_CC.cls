public with sharing class DisplayContacts_CC {

    /**
     * This custom controller is used to do a wildcard SOSL search across all fields for Contacts.
     * Use a StandardSetController to handle pagination and potentially a large set of records
     */

    // Constructor
    public DisplayContacts_CC() {
        searched = false;
    }

    public String searchText { get; set; }                          // Search string entered by user
    public Boolean searched { get; set; }                           // Indicates whether search has been done
    public ApexPages.StandardSetController setCon { get; set; }     // Standard Set Controller

    // Indicates whether records were found
    public Boolean matches {
        get {
            return ( (contacts != null) && (contacts.size() != 0) );
        }
    }

    // List of Contacts displayed on the page
    public List<Contact> contacts {
        get {
            if (setCon != null ) {
                return (List<Contact>)setCon.getRecords();
            } else {
                return null;
            }
        }
    }

    // Action method initiated by user
    public void Search() {

        if (String.isNotBlank(searchText) && searchtext.length() > 1) {
        
            if (!searchText.endsWith('*')) {
                searchText = searchText + '*';
            }

            List<sObject> contacts = [FIND :searchText
                                      IN ALL FIELDS
                                      RETURNING Contact (Id, Name, Email, Phone, Account.Name)][0];

            setCon = new ApexPages.StandardSetController(contacts);
            
            setCon.setPageNumber(1);    // Start at the first page
            setCon.setPageSize(10);     // Set a default page size

            searched = true;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,
                                                      'Please enter search text at least two characters long'));
        }
    }
}