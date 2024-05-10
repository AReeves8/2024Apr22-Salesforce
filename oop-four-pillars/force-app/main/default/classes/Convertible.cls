
/**

    can inherit from virtual classes

 */

public class Convertible extends Car{
    public Convertible() {

    }


    public override void oilChange() {
        System.debug('Convertible gets an oil change');
    }
}