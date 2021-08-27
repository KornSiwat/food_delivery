import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/screens/restaurant_feed/restaurant_feed_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: _app(
        title: "Robin Food",
        theme: _theme(),
        home: RestaurantFeedScreen(),
      ),
    );
  }

  Widget _app({
    required String title,
    required Widget home,
    ThemeData? theme,
  }) {
    return MaterialApp(
      title: title,
      theme: theme,
      home: home,
    );
  }

  ThemeData _theme() {
    return ThemeData(
      primaryColor: Colors.white,
    );
  }
}
