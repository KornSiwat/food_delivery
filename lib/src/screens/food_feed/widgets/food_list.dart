import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/screens/common/widgets/restaurant_change_dialog.dart';
import 'package:food_delivery/src/screens/food_detail/food_detail_screen.dart';

part 'food_item.dart';

class FoodList extends StatelessWidget {
  const FoodList({
    Key? key,
    required this.restaurant,
    required this.foods,
  }) : super(key: key);

  final Restaurant restaurant;
  final List<Food> foods;

  @override
  Widget build(BuildContext context) {
    return _foodList(
      restaurant: restaurant,
      foods: foods,
    );
  }

  Widget _foodList({
    required List<Food> foods,
    required Restaurant restaurant,
  }) {
    return ListView.separated(
      itemCount: foods.length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        Food food = foods[index];

        return FoodItem(food: food, restaurant: restaurant);
      },
      separatorBuilder: (
        BuildContext context,
        int index,
      ) {
        return const Divider();
      },
    );
  }
}
