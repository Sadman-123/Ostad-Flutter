class Car {
  String brand;
  String model;
  int year;
  double milesDriven;
  static int numberOfCars = 0;
  Car(this.brand, this.model, this.year, this.milesDriven) {
    numberOfCars++;
  }
  drive(double miles) {
    milesDriven += miles;
  }

  getMilesDriven() {
    return milesDriven;
  }

  String getBrand() {
    return brand;
  }

  String getModel() {
    return model;
  }

  int getYear() {
    return year;
  }

  int getAge() {
    int n = DateTime.now().year;
    int xx = n - year;
    return xx;
  }
}

void main() {
  Car car1 = new Car("Ferrari", "s686", 1989, 1200);
  Car car2 = new Car("BMW", "M434", 1971, 1300);
  Car car3 = new Car("Lamborghini", "xyz123", 1992, 1400);
  car1.drive(5.4);
  car2.drive(5.5);
  car3.drive(12.3);
  print(
      "Brand:${car1.getBrand()}, Model:${car1.getModel()}, Year:${car1.getYear()}, Miles:${car1.getMilesDriven()}");
  print(
      "Brand:${car2.getBrand()}, Model:${car2.getModel()}, Year:${car2.getYear()}, Miles:${car2.getMilesDriven()}");
  print(
      "Brand:${car3.getBrand()}, Model:${car3.getModel()}, Year:${car3.getYear()}, Miles:${car3.getMilesDriven()}");
  print("Age of ${car1.getBrand()} is ${car1.getAge()} years old");
  print("Age of ${car2.getBrand()} is ${car2.getAge()} years old");
  print("Age of ${car3.getBrand()} is ${car3.getAge()} years old");
  print("Total ${Car.numberOfCars} Cars");
}
