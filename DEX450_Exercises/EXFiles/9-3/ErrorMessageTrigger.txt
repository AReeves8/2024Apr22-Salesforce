trigger ErrorMessageTrigger on Error_Message__e (after insert) {

    List<Error_Log__c> errs = new List<Error_Log__c>();
    
    // TODO #1:  Loop through trigger.new and create Error_Log__c records 
    //   for each platform event and add to the errs list
     
    insert errs;
}