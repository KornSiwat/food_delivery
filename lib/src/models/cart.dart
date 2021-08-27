import 'package:collection/collection.dart';
import 'package:food_delivery/src/models/food_item.dart';
import 'package:food_delivery/src/models/restaurant.dart'; // You have to add this manually, for some reason it cannot be added automatically

typedef FoodId = String;

class Cart {
  // Restaurant? restaurant;
  // Map<FoodId, FoodItem> _foodItems = {};

  Cart(this.restaurant, this._foodItems);

  Cart copy() {
    return Cart(restaurant, _foodItems);
  }

  Restaurant? restaurant;
  Map<FoodId, FoodItem> _foodItems = {};

  List<FoodItem> get foodItems {
    return _foodItems.values.toList();
  }

  FoodItem? getFoodItem(FoodId foodId) {
    return foodItems.firstWhereOrNull((foodItem) => foodItem.food.id == foodId);
  }

  bool isCartBelongToRestaurant(Restaurant restaurant) {
    return this.restaurant == restaurant || this.restaurant == null;
  }

  bool isEmpty() {
    return foodItems.isEmpty;
  }

  int totalPrice() {
    return foodItems.fold(
      0,
      (sum, foodItem) => (sum + foodItem.totalPrice()),
    );
  }

  void add(FoodItem foodItem) {
    _foodItems[foodItem.food.id] = foodItem;
  }

  void removeFoodItem(FoodId foodId) {
    _foodItems.remove(foodId);
  }

  void empty() {
    restaurant = null;
    _foodItems.clear();
  }
}
