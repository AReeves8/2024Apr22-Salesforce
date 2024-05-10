
/**
    ABSTRACTION
        - only showing what needs to be shown

        - all methods in an interface are 100% abstract
            - no method body
            - no defined access level (implicitly private)

        - "implements" keyword for inheritance
 */

public interface Driveable {
    
    // all methods do not have a method body - implementation will occur in child classes
    Void drive();

}