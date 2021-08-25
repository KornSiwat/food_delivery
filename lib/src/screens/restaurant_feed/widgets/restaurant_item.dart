import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/screens/food_feed/food_feed_screen.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) => _restaurantItem(
        image:
            _restaurantImage(image: AssetImage('images/restaurants/momo.png')),
        name: _restaurantName(name: restaurant.name),
        tapHandler: () => _navigateToRestaurantFeedScreen(context),
      );

  Widget _restaurantItem({
    required Widget image,
    required Widget name,
    required Function tapHandler,
  }) =>
      GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => tapHandler(),
          child: Container(
              margin: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    image,
                    name,
                  ])));

  Widget _restaurantImage({required ImageProvider image}) => Expanded(
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Image(
            image: image,
            fit: BoxFit.cover,
          )));

  Widget _restaurantName({required String name}) => Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ));

  void _navigateToRestaurantFeedScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FoodFeedScreen(restaurant: restaurant)));
  }
}
