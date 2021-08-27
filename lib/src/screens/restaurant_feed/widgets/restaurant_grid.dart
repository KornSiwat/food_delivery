import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/screens/food_feed/food_feed_screen.dart';

part 'restaurant_item.dart';

class RestaurantGrid extends StatelessWidget {
  const RestaurantGrid({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: restaurants
            .map((restaurant) => RestaurantItem(restaurant: restaurant))
            .toList());
  }
}
