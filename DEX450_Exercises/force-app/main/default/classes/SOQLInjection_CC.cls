public class SOQLInjection_CC {

    // The User's input
    public String name { get; set; }

    // Example input good: CERTIFICATION-00001
    // Example input bad:  test' OR name like '%

    public List<Certification_Held__c> queryResult { get; set; }

    public void query() {

        // trim whitespace from search term
        name = name.trim();

        // Example of safe dynamic soql with bind variable.
        // Bind variables using :expression mitigate SOQL Injection from string concatenation.
        //queryResult = [
        //   SELECT Name, Certified_Professional__r.Name, Certification__r.Name, Certification__r.Number_of_Certified_Professionals__c
        //     FROM Certification_Held__c
        //    WHERE Name = :name
        //    LIMIT 1
        //];
        
        // Example of unsafe dynamic soql with string concatenation.
        // Because the filter criteria is passed as-is from the web form,
        // this exposes a SOQL Injection vulnerability.
        //name = String.escapeSingleQuotes(name);
        String qryString =
             ' SELECT Name, Certified_Professional__r.Name, Certification__r.Name, Certification__r.Number_of_Certified_Professionals__c ' +
             ' FROM Certification_Held__c ' +
             ' WHERE Name =\'' + name + '\'';

        queryResult = Database.query( qryString );        
    }
}