class CarModel {
  int speed;
  String direction; //forward F, backward B, left L, right R, stoped S

  CarModel({required this.speed, required this.direction});

  String convertDataToMessage() {
    String message = "$direction${speed.toString()}";
    return message;
  }
}
