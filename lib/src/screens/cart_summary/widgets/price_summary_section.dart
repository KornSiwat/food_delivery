import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:provider/provider.dart';

class PriceSummarySection extends StatelessWidget {
  const PriceSummarySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _section(
        title: _titleText(title: "Total Price"),
        priceSummary: _priceSummary(
          totalPrice: _cart(context).totalPrice().toString(),
        ),
      );

  Widget _section({
    required Widget title,
    required Widget priceSummary,
  }) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            SizedBox(
              height: 16,
            ),
            priceSummary,
          ],
        ),
      );

  Widget _titleText({required String title}) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );

  Widget _priceSummary({
    required String totalPrice,
  }) =>
      Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        totalPrice,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Cart _cart(BuildContext context) => Provider.of<Cart>(context, listen: true);
}
