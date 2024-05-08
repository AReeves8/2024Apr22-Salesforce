public class OrderProcessor {
    
    
    /**
        APEX SHARING
            determine if your apex class will respect RECORD level access

            - with sharing: respect sharing model
            - without sharing: no respect for sharing model (so everyone can access all records)
            - inherited sharing: it will use the sharing rule of the calling class
            - default (don't specify): in most cases, this behaves like inherited sharing
    
     */


    public enum OrderTypeEnum { ONLINE, IN_STORE, OVER_THE_PHONE }


    private Integer orderNumber;
    private OrderTypeEnum orderType;

    // constructors
    public OrderProcessor() {

    }

    // constructor overloading
    public OrderProcessor(Integer orderNumber) {
        this.orderNumber = orderNumber;
    }

    public OrderProcessor(Integer orderNumber, String orderType) {
        this.orderNumber = orderNumber;
        this.orderType = OrderTypeEnum.valueof(orderType);  // converts string to enum
    }



    // getters and setters
    public Integer getOrderNumber() {
        return this.orderNumber;
    }
    public Void setOrderNumber(Integer orderNumber) {
        this.orderNumber = orderNumber;
    }



    public Boolean processOrder() {

        // don't have to worry about fall-thru
        switch on this.orderType {

            when ONLINE {
                return this.orderNumber > 1000;
            }
            when IN_STORE {
                return this.orderNumber > 2000;
            }
            when OVER_THE_PHONE {
                return this.orderNumber > 3000;
            }
            when else {
                return false;
            }
        }
    }


}