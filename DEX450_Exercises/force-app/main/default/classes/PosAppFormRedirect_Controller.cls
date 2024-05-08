public class PosAppFormRedirect_Controller {

    public PageReference doRedirect() {
        
        String apiUrl = [select id, User_API_URL__c from User where Id = :UserInfo.getUserId()].User_API_URL__c;
        
        return new PageReference('https://dev502-exercises.herokuapp.com/emailHandler?sid='+UserInfo.getSessionId() 
        + '&url=' + apiUrl + '&uname=' + UserInfo.getUserName());
    }
}