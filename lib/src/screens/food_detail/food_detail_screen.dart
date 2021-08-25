import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/food_order.dart';
import 'package:food_delivery/src/screens/food_detail/widgets/food_info.dart';
import 'package:food_delivery/src/screens/food_detail/widgets/order_panel.dart';
import 'package:provider/provider.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key, required this.food}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) => _screen(
        appBar: _appBar(title: food.name),
        body: _body(
          foodInfo: FoodInfo(food: food),
          orderPanel: OrderPanel(
            foodOrder: _getOrCreateFoodOrder(context),
          ),
        ),
        tapHandler: () => FocusManager.instance.primaryFocus?.unfocus(),
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

  Widget _body({required Widget foodInfo, required Widget orderPanel}) {
    return SafeArea(
      child: Column(
        children: [
          foodInfo,
          orderPanel,
        ],
      ),
    );
  }

  FoodOrder _getOrCreateFoodOrder(BuildContext context) {
    Cart cart = Provider.of<Cart>(context, listen: false);

    return cart.getFoodOrderByFoodID(food.id) ?? FoodOrder(food, 1, "");
  }
}
