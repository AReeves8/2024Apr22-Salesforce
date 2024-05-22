/**
    INHERITANCE
        - concrete classes (non-abstract) can be declared as virtual
            - makes a class inheritable

            - abstract classes and interfaces are already inheritable by default, but not concrete classes.

 */

public virtual class Car extends Vehicle {
    
    
    private String engine;
    private String make;
    private String model;


    /**
        FINAL and STATIC
            final - means the value has to be set when the variable is inititlized and the value cannot change
                - set when it is declared or in constructors

            static - means every reference to this variable will access the same location in memory
                - don't have to initialize object to access
                    - initilized as soon as the class is

            final and satic together gives us constants
     */
    private final static Integer NUM_AXLES = 2;

    // no-arg constructor    
    public Car() {
        System.debug('no arg Car constructor');
    }

    public Car(Integer numWheels) {

        
        super('car', numWheels);
        System.debug('numwheels constructor');
    }

    // parameterized constructor
    public Car(String engine, String make, String model, Integer numWheels) {

        /**
            THIS() AND SUPER()
                - only have one of these per constructor
                - MUST be the first line of constructor
                - can pass parameters to other constructors

                - this() - calls a constructor in the current class
                - super() - calls a constructor in the parent class
                    - happens implicity - every class inherits from sObject

                - constructor chaining
         */ 

        this(numWheels);

        this.engine = engine;
        this.make = make;
        this.model = model;

    }

    public String getEngine() {
        return this.engine;
    }
    public void setEngine(String engine) {
        this.engine = engine;
    }

    public String getMake() {
        return this.make;
    }
    public void setMake(String make) {
        this.make = make;
    }

    public String getModel() {
        return this.model;
    }
    public void setModel(String model) {
        this.model = model;
    }


    /**
        PLOYMORPHISM
            - "many forms"


            - method overriding
                - happens at runtime
                - when you implement a method from a parent inside of a child class
                - in SF, you need the 'override' keyword
    
            - SObject methods: toString, equals, hashcode
     */
    public override String toString() {
        return 'Car: engine=' + this.engine + ', make=' + this.make + ', model=' + this.model;
    }


    // only virtual methods can be overridden in child class
    public virtual void oilChange() {
        System.debug('car gets an oil change');
    }

}