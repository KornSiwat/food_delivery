import 'package:flutter/material.dart';
import 'package:food_delivery/facades/food_facade.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/common/widgets/loading_indicator.dart';
import 'package:food_delivery/screens/food_feed/widgets/food_row.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  _FoodListState createState() => _FoodListState(restaurant);
}

class _FoodListState extends State<FoodList> {
  _FoodListState(this._restaurant);
  final Restaurant _restaurant;
  late final Future<List<Food>> _foods =
      FoodFacade().fetchFoods(_restaurant.id);

  @override
  Widget build(BuildContext context) => _foodList(
        foods: _foods,
        restaurant: _restaurant,
      );

  Widget _foodList({
    required Restaurant restaurant,
    required Future<List<Food>> foods,
  }) =>
      FutureBuilder(
        future: foods,
        builder: (BuildContext context, AsyncSnapshot<List<Food>> foods) =>
            foods.hasData
                ? _loadedFoodList(foods: foods.data!, restaurant: restaurant)
                : LoadingIndicator(),
      );

  Widget _loadedFoodList(
          {required List<Food> foods, required Restaurant restaurant}) =>
      ListView.separated(
        itemCount: foods.length,
        itemBuilder: (BuildContext context, int index) {
          Food food = foods[index];

          return FoodRow(food: food, restaurant: _restaurant);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
}
