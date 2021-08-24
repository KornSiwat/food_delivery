import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/food_order.dart';
import 'package:food_delivery/screens/cart/widgets/food_order_row.dart';
import 'package:provider/provider.dart';

class FoodOrderSection extends StatelessWidget {
  const FoodOrderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _section(
        title: _titleText(title: "Orders"),
        foodOrderList: _foodOrderList(foodOrders: _foodOrders(context)),
      );

  Widget _section({required Widget title, required Widget foodOrderList}) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            SizedBox(
              height: 16,
            ),
            foodOrderList,
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

  Widget _foodOrderList({required List<FoodOrder> foodOrders}) => Row(
        children: [
          Expanded(
            child: Column(
                children: foodOrders
                    .map(
                      (foodOrder) => Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: FoodOrderRow(foodOrder: foodOrder),
                      ),
                    )
                    .toList()),
          ),
        ],
      );

  List<FoodOrder> _foodOrders(BuildContext context) =>
      Provider.of<Cart>(context, listen: true).foodOrders;
}
