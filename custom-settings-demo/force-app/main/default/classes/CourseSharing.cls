public with sharing class CourseSharing {
    public CourseSharing() {

    }

    // dynamiclaly grants Record Level Access
    public static Boolean shareWithRead(Id recordId, Id userId) {

        // create the share object
        Course__Share courseShare = new Course__Share();

        // set record to share
        courseShare.ParentId = recordId;

        // set who to share to
        courseShare.UserOrGroupId = userId;

        // set access level
        courseShare.AccessLevel = 'Read';

        // optional: set Manual share
        courseShare.RowCause = Schema.Course__Share.RowCause.Manual;

        // inserting into the db will cause the share to happen
        try {
            insert courseShare;
            return true;
        } catch (Exception e) {
            return false;
        }
    }

}