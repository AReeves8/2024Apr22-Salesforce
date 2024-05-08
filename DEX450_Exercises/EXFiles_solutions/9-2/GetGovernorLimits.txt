public class GetGovernorLimits {
    
    /*TODO#1: 
     * Inside the LimitsResult inner class declare two invocable variables called 
     * limitUsage and limitValue with appropriate labels. 
     * Both variables should be public with the datatype Integer
     */
    public class LimitsResult {
        @InvocableVariable(label='Limit Usage') public Integer limitUsage;
        @InvocableVariable(label='Limit Value') public Integer limitValue;
    }

    /*TODO#2:
     * Define the getLimit method as an invocable method with the label 'Get Governor Limit Usage'
     */
    @InvocableMethod(label='Get Governor Limit Usage')
    public static List<LimitsResult> getLimit(List<String> limitNames) {

        List<LimitsResult> results = new List<LimitsResult>();

        for (String limitName : limitNames) {

            LimitsResult result = new LimitsResult();

            switch on limitName.toUpperCase() {
                when 'QUERYROWS' {
                    result.limitUsage = Limits.getQueryRows();
                    result.limitValue = Limits.getLimitQueryRows();
                }
                /*TODO#3
                 * Add additional statements for QUERIES, DMLROWS and DMLSTATEMENTS making 
                 * appropriate calls to the Limits class methods for number of queries, number of DML rows
                 * and number of DML statements respectively.
                 */
                when 'QUERIES' {
                    result.limitUsage = Limits.getQueries();
                    result.limitValue = Limits.getLimitQueries();
                }
                when 'DMLROWS' {
                    result.limitUsage = Limits.getDmlRows();
                    result.limitValue = Limits.getLimitDmlRows();
                }
                when 'DMLSTATEMENTS' {
                    result.limitUsage = Limits.getDmlStatements();
                    result.limitValue = Limits.getLimitDmlStatements();
                }
                when else {
                    result.limitUsage = -1;
                    result.limitValue = -1;
                }
            }
            results.add(result);
        }
        
        return results;
    }
}