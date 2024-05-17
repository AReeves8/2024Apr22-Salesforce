//TODO #1: Enter the DML events
trigger CourseDeliveryTrigger on Course_Delivery__c (before insert, before update) {
    
    Trigger_Switch__mdt tsw = Trigger_Switch__mdt.getInstance('CourseDeliveryTriggerSwitch');
    if(tsw == null || tsw.Active_Flag__c) {
        
        // TODO #1: Invoke the static method of the 
        //   CourseDeliveryTriggerHandler class called 
        //   preventInvalidCourseDeliveries and pass in the Trigger.new 
        //   and Trigger.oldMap variables.	
        CourseDeliveryTriggerHandler.preventInvalidCourseDeliveries(Trigger.new, Trigger.oldMap);
        
    }
}