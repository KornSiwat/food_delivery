import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/food_item.dart' as model;
import 'package:food_delivery/src/screens/food_detail/food_detail_screen.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    Key? key,
    required this.foodItem,
  }) : super(key: key);

  final model.FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return _foodItemRow(context,
        foodItemInfo: _foodItemInfo(
          quantity: foodItem.quantity.toString(),
          name: foodItem.food.name,
          note: foodItem.note,
          price: foodItem.totalPrice().toString(),
        ),
        tapHandler: () =>
            _navigateToFoodDetailScreen(context, food: foodItem.food));
  }

  Widget _foodItemRow(
    BuildContext context, {
    required Widget foodItemInfo,
    required Function tapHandler,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => tapHandler(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          // color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: foodItemInfo,
          ),
        ),
      );

  Widget _foodItemInfo({
    required String quantity,
    required String name,
    required String note,
    required String price,
  }) =>
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _quantityText(quantity),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      note,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]);

  Widget _quantityText(String quantity) {
    return Container(
      padding: EdgeInsets.only(bottom: 4, top: 4, left: 8, right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Text(
        quantity,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigateToFoodDetailScreen(BuildContext context,
          {required Food food}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodDetailScreen(food),
        ),
      );
}
