public with sharing class CustomSettingsDemo {
    public CustomSettingsDemo() {

    }


    public static String getStateAbbreviation() {


        //State_Codes__c codes = State_Codes__c.getInstance('00eHu000001chmf');         // ID for Sales User Profile
        State_Codes__c codes = State_Codes__c.getInstance(UserInfo.getProfileId());     // UserInfo contains information about the current running user
        return codes.State_Abbreviation__c;
    }


}