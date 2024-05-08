trigger CourseAttendeeTrigger on Course_Attendee__c (after insert, after update) {
    if(Trigger.isAfter) {
        if (Trigger.isInsert) {
            CourseAttendeeTriggerHandler.provideAccessLMS(Trigger.new,Trigger.oldMap);
        }
        if (Trigger.isUpdate) {
            CourseAttendeeTriggerHandler.provideAccessLMS(Trigger.new,Trigger.oldMap);
        }
    }
}