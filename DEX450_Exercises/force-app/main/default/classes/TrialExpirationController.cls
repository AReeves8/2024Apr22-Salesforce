public without sharing class TrialExpirationController {
    
    @AuraEnabled(cacheable=true)
    public static Integer getExpirationDaysLeft () {
        
        Integer daysLeft;
        
        try {
            Organization org = [SELECT TrialExpirationDate FROM Organization];
            DateTime expDate = org.TrialExpirationDate;
            
            daysLeft = Date.today().daysBetween(Date.valueof(expDate)) - 1;
        }
        catch (Exception e) {
            throw new AuraHandledException('Unable to get org expiration date');   
        }

        return daysLeft;        
    }
}