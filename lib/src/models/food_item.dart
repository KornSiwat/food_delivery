import 'package:food_delivery/src/models/food.dart';

class FoodItem {
  FoodItem(this.food, this.quantity, this.note);

  Food food;
  int quantity;
  String note;

  int totalPrice() {
    return quantity * food.price;
  }
}
