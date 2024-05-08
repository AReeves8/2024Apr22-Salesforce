public class CourseAttendeeTriggerHandler {
    
    public static void provideAccessLMS (List<Course_Attendee__c> courseAttendees, Map<Id,Course_Attendee__c> oldMap) {
        List<Id> courseAttendeesToChangeAccess = new List <Id>();
        for (Course_Attendee__c cA : courseAttendees) {
            if (cA.status__c == 'Enrolled') {
                if (oldMap == null || !oldMap.containsKey(cA.Id) || oldMap.get(cA.id).status__c != cA.status__c) {
                    courseAttendeesToChangeAccess.add(cA.Id);
                }  
            }
        }
        notifyForLMSAccess(courseAttendeesToChangeAccess);
    }
   
    private static void notifyForLMSAccess(List<Id> idsToChangeAccess) {
        if (idsToChangeAccess.size() > 0) {
            String emails = '';
            Integer numberOfNewEnrollees = 0;
            for (List<Course_Attendee__c> caList : [SELECT Course_Delivery__r.Name, Student__r.email 
                                                          FROM Course_Attendee__c 
                                                          WHERE Id in :idsToChangeAccess
                                                          ORDER BY Course_Delivery__r.Name]) {
                for (Course_Attendee__c ca: caList) {
                    emails += '\n' + ca.Course_Delivery__r.Name + ': ' + ca.Student__r.email; 
                    numberOfNewEnrollees++;
                }             
            }
            List<User> TrainingCoordinatorIds = [SELECT Id FROM User WHERE ProfileId IN 
                                                 (Select Id from Profile where name = 'Training User')];
            Task newTask = new Task(Subject='Add ' + numberOfNewEnrollees + ' new Enrollees to LMS',
                                    Description = 'Provide access for: ' + emails,
                                    Priority = 'Normal', 
                                    OwnerId = TrainingCoordinatorIds[0].Id);             
            insert newTask;
        }
    }
}