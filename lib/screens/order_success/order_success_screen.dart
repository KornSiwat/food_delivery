import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/screens/restaurant_feed/restaurant_feed_screen.dart';
import 'package:provider/provider.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _screen(
        tapHandler: () => FocusManager.instance.primaryFocus?.unfocus(),
        appBar: _appBar(title: "Order Status"),
        body: _body(
          orderStatusText: _orderStatusText(orderStatus: "Success"),
          backToRestaurantFeedButton: _backToRestaurantFeedButton(
            label: "done",
            tapHandler: () {
              _clearCart(context);
              _navigateToRestaurantFeed(context);
            },
          ),
        ),
      );

  Widget _screen({
    required Function tapHandler,
    required AppBar appBar,
    required Widget body,
  }) =>
      GestureDetector(
        onTap: () => tapHandler,
        child: Scaffold(
          appBar: appBar,
          body: body,
        ),
      );

  AppBar _appBar({required String title}) => AppBar(
        title: Text(title),
      );

  Widget _body({
    required Widget orderStatusText,
    required Widget backToRestaurantFeedButton,
  }) =>
      SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: orderStatusText),
            backToRestaurantFeedButton,
          ],
        ),
      );

  Widget _orderStatusText({required String orderStatus}) =>
      Center(child: Text(orderStatus));

  Widget _backToRestaurantFeedButton({
    required String label,
    required Function tapHandler,
  }) =>
      Center(
          child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: ElevatedButton(
            onPressed: () => tapHandler(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent)),
      ));

  Cart _cart(BuildContext context) => Provider.of<Cart>(context, listen: false);

  void _clearCart(BuildContext context) => _cart(context).empty();

  void _navigateToRestaurantFeed(BuildContext context) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => RestaurantFeedScreen(),
        ),
        (route) => false,
      );
}
