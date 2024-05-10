

// Vehicle hondaCivic = new Vehicle('car', 4);
// hondaCivic.drive();

Car toyotaPrius = new Car('small', 'toyota', 'prius', 4);
System.debug(toyotaPrius);
System.debug(toyotaPrius.toString());


/**
    COVARIANCE
        ploymorphism
        allows a child class to act in place of a parent class

 */

Vehicle car = new Car('small', 'kia', 'rio', 4);
car.drive();

Driveable car2 = new Car('small', 'hyundai', 'elantra', 4);
car2.drive();



Convertible topDownCar = new Convertible();
topDownCar.oilChange();
toyotaPrius.oilChange();
