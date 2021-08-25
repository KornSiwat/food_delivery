import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/screens/restaurant_feed/restaurant_feed_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Cart(),
        child: _app(
          title: "Robin Food",
          theme: _theme(),
          home: RestaurantFeedScreen(),
        ),
      );

  Widget _app({
    required String title,
    required Widget home,
    ThemeData? theme,
  }) =>
      MaterialApp(
        title: title,
        theme: theme,
        home: home,
      );

  ThemeData _theme() => ThemeData(
        primaryColor: Colors.white,
      );
}
