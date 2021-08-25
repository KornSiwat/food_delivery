import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/cart/widgets/delivery_info_section.dart';
import 'package:food_delivery/src/screens/cart/widgets/food_order_section.dart';
import 'package:food_delivery/src/screens/cart/widgets/payment_section.dart';
import 'package:food_delivery/src/screens/order_success/order_success_screen.dart';

class CartSummaryScreen extends StatelessWidget {
  const CartSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _screen(
        tapHandler: () => FocusManager.instance.primaryFocus?.unfocus(),
        appBar: _appBar(title: "Cart Summary"),
        body: _body(
          addressSection: DeliveryInfoSection(),
          foodOrderSection: FoodOrderSection(),
          paymentSection: PaymentSection(),
          orderButton: _orderButton(
            label: "order",
            tapHandler: () => _navigateToOrderSuccessScreen(context),
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
    required Widget addressSection,
    required Widget foodOrderSection,
    required Widget paymentSection,
    required Widget orderButton,
  }) =>
      SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  addressSection,
                  foodOrderSection,
                  paymentSection,
                ],
              ),
            ),
            orderButton,
          ],
        ),
      );

  Widget _orderButton({
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
                style: TextStyle(fontSize: 18),
              ),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.redAccent)),
      ));

  void _navigateToOrderSuccessScreen(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
}
