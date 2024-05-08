trigger CourseTrigger on Course__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) { 
        CourseTriggerHandler.checkStatus(Trigger.new, Trigger.oldMap, Trigger.newMap);
    }
}