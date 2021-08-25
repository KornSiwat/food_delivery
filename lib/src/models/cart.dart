import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:food_delivery/src/models/food_order.dart';
import 'package:food_delivery/src/models/restaurant.dart'; // You have to add this manually, for some reason it cannot be added automatically

typedef FoodID = String;

class Cart extends ChangeNotifier {
  Restaurant? restaurant;
  Map<FoodID, FoodOrder> _foodOrders = {};

  List<FoodOrder> get foodOrders => _foodOrders.values.toList();

  bool isCartBelongToRestaurant(Restaurant restaurant) =>
      this.restaurant == restaurant || this.restaurant == null;

  bool isEmpty() => foodOrders.isEmpty;

  FoodOrder? getFoodOrderByFoodID(FoodID foodID) =>
      foodOrders.firstWhereOrNull((foodOrder) => foodOrder.food.id == foodID);

  void update(FoodOrder foodOrder) {
    _foodOrders[foodOrder.food.id] = foodOrder;

    notifyListeners();
  }

  void removeFoodOrder(FoodID foodID) {
    _foodOrders.remove(foodID);

    notifyListeners();
  }

  void empty() {
    restaurant = null;
    _foodOrders.clear();

    notifyListeners();
  }
}
