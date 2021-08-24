import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_order.dart';
import 'package:food_delivery/screens/food_detail/food_detail_screen.dart';

class FoodOrderRow extends StatelessWidget {
  const FoodOrderRow({Key? key, required this.foodOrder}) : super(key: key);
  final FoodOrder foodOrder;

  @override
  Widget build(BuildContext context) {
    return _foodOrderRow(context,
        foodOrderInfo: _foodOrderInfo(
          quantity: foodOrder.quantity.toString(),
          name: foodOrder.food.name,
          note: foodOrder.note,
          price: foodOrder.totalPrice().toString(),
        ),
        tapHandler: () =>
            _navigateToFoodDetailScreen(context, food: foodOrder.food));
  }

  Widget _foodOrderRow(
    BuildContext context, {
    required Widget foodOrderInfo,
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
            child: foodOrderInfo,
          ),
        ),
      );

  Widget _foodOrderInfo({
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
          builder: (context) => FoodDetailScreen(food: food),
        ),
      );
}
