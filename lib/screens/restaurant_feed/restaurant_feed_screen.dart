import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/screens/common/widgets/cart_floating_button.dart';
import 'package:food_delivery/screens/restaurant_feed/widgets/restaurant_grid.dart';
import 'package:provider/provider.dart';

class RestaurantFeedScreen extends StatelessWidget {
  const RestaurantFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _screen(
        appBar: _appBar(title: "Restaurants"),
        body: _body(restaurantGrid: RestaurantGrid()),
        tapHandler: () => FocusManager.instance.primaryFocus?.unfocus(),
        floatingActionButton:
            _isCartEmpty(context) ? null : CartFloatingButton(),
      );

  Widget _screen({
    required Function tapHandler,
    required AppBar appBar,
    required Widget body,
    required Widget? floatingActionButton,
  }) =>
      GestureDetector(
        onTap: () => tapHandler,
        child: Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
        ),
      );

  AppBar _appBar({required String title}) => AppBar(
        title: Text(title),
      );

  Widget _body({required restaurantGrid}) {
    return SafeArea(child: restaurantGrid);
  }

  bool _isCartEmpty(context) =>
      Provider.of<Cart>(context, listen: true).isEmpty();
}
