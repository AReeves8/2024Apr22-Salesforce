/**

    ABSTRACT CLASS
        - a class that *can* have abstract methods
            - abstract methods are methods that are only declared, but not defined and will need to be implented in a child class.
        - they cannot be instaniated
        

 */

public abstract class Vehicle implements Driveable {
    
    
    private String type;
    private Integer numWheels;
    
    
    public Vehicle() {

    }
    public Vehicle(String type, Integer numWheels) {
        this.type = type;
        this.numWheels = numWheels;

        System.debug('vehicle constructor');
    }

    public String getType() {
        return this.type;
    }
    public Void setType(String type) {
        this.type = type;
    }

    public Integer getNumWheels() {
        return this.numWheels;
    }
    public Void setNumWheels(Integer numWheels) {

        // one advatage to having ENCAPSULATION with getters and setters is data validation
        if(numWheels > 0) {
            this.numWheels = numWheels;
        }
    }

    // implementing the drive method from Driveable interface
    public void drive() {
        System.debug( this.type + ' drives on '  + numWheels + ' wheels.');
    }

}