class Rectangle {
  double length;
  double width;

  Rectangle(this.length, this.width);

  double calculateArea() {
    return length * width;
  }
}

class Circle {
  double radius;

  Circle(this.radius);

  double calculateArea() {
    return 3.14159 * radius * radius;
  }
}
