import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/food_item.dart';
import 'package:food_delivery/src/models/restaurant.dart';

typedef _State = Cart;

class CartCubit extends Cubit<_State> {
  CartCubit() : super(Cart(null, {}));

  void setRestaurant(Restaurant restaurant) {
    state.restaurant = restaurant;

    emit(state);
  }

  void addFoodItem(FoodItem foodItem) {
    state.add(foodItem);

    emit(
      state.copy(),
    );
  }

  void remove(FoodItem foodItem) {
    state.removeFoodItem(foodItem.food.id);

    emit(
      state.copy(),
    );
  }

  void empty() {
    emit(Cart(null, {}));
  }
}
