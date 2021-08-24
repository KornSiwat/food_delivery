import 'package:flutter/material.dart';
import 'package:food_delivery/facades/restaurant_facade.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/common/widgets/loading_indicator.dart';
import 'package:food_delivery/screens/restaurant_feed/widgets/restaurant_item.dart';

class RestaurantGrid extends StatefulWidget {
  const RestaurantGrid({Key? key}) : super(key: key);

  @override
  _RestaurantGridState createState() => _RestaurantGridState();
}

class _RestaurantGridState extends State<RestaurantGrid> {
  final Future<List<Restaurant>> _restaurants =
      RestaurantFacade().fetchRestaurants();

  @override
  Widget build(BuildContext context) =>
      _restaurantGrid(restaurants: _restaurants);

  Widget _restaurantGrid({required Future<List<Restaurant>> restaurants}) =>
      FutureBuilder(
        future: _restaurants,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Restaurant>> restaurants,
        ) =>
            restaurants.hasData
                ? _loadedRestaurantGrid(restaurants: restaurants.data!)
                : LoadingIndicator(),
      );

  Widget _loadedRestaurantGrid({required List<Restaurant> restaurants}) =>
      GridView.count(
          crossAxisCount: 2,
          children: restaurants
              .map((restaurant) => RestaurantItem(restaurant: restaurant))
              .toList());
}
