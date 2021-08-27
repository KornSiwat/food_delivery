import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/order_success/order_success_screen.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _orderButton(
      label: "order",
      tapHandler: () => _navigateToOrderSuccessScreen(context),
    );
  }

  Widget _orderButton({
    required String label,
    required Function tapHandler,
  }) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
          onPressed: () => tapHandler(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 18),
            ),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent)),
    ));
  }

  void _navigateToOrderSuccessScreen(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
}
