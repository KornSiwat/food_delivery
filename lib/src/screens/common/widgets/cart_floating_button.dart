import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/cart_summary/cart_summary_screen.dart';

class CartFloatingButton extends StatelessWidget {
  const CartFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _cartButton(
        icon: const Icon(Icons.shopping_bag),
        tapHandler: () => _navigateToCartSummaryScreen(context),
      );

  Widget _cartButton({required Icon icon, required Function tapHandler}) =>
      FloatingActionButton(
        onPressed: () => tapHandler(),
        child: icon,
        backgroundColor: Colors.red.shade400,
      );

  void _navigateToCartSummaryScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartSummaryScreen()));
  }
}
