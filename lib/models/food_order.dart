import 'package:food_delivery/models/food.dart';

class FoodOrder {
  FoodOrder(this.food, this.quantity, this.note);
  Food food;
  int quantity;
  String note;

  int totalPrice() => (quantity * food.price);
}
