import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/screens/common/widgets/cart_floating_button.dart';
import 'package:food_delivery/src/screens/food_feed/widgets/food_list.dart';
import 'package:provider/provider.dart';

class FoodFeedScreen extends StatelessWidget {
  const FoodFeedScreen({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) => _screen(
        appBar: _appBar(title: restaurant.name),
        body: _body(
          foodList: FoodList(
            restaurant: restaurant,
          ),
        ),
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

  Widget _body({required Widget foodList}) {
    return SafeArea(child: foodList);
  }

  bool _isCartEmpty(context) =>
      Provider.of<Cart>(context, listen: true).isEmpty();
}
