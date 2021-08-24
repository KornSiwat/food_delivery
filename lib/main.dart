import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/screens/restaurant_feed/restaurant_feed_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => Cart(),
    child: RobinFood(),
  ));
}

class RobinFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robin Food',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RestaurantFeedScreen(),
    );
  }
}
