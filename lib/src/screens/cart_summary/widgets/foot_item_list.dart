import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/food_item.dart' as model;
import 'package:food_delivery/src/screens/cart_summary/widgets/food_item.dart';

class FoodItemSection extends StatelessWidget {
  const FoodItemSection({Key? key, required this.foodItems}) : super(key: key);

  final List<model.FoodItem> foodItems;

  @override
  Widget build(BuildContext context) => _section(
        title: _titleText(title: "Orders"),
        foodOrderList: _foodItemList(foodItems: foodItems),
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

  Widget _foodItemList({required List<model.FoodItem> foodItems}) => Row(
        children: [
          Expanded(
            child: Column(
                children: foodItems
                    .map(
                      (foodItem) => Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: FoodItem(foodItem: foodItem),
                      ),
                    )
                    .toList()),
          ),
        ],
      );
}
