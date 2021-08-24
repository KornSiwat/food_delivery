import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/common/widgets/restaurant_change_dialog.dart';
import 'package:food_delivery/screens/food_detail/food_detail_screen.dart';
import 'package:provider/provider.dart';

class FoodRow extends StatelessWidget {
  const FoodRow({Key? key, required this.food, required this.restaurant})
      : super(key: key);
  final Food food;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) => _foodRow(context,
      image: _foodImage(image: AssetImage("images/foods/pizza.jpeg")),
      info: _foodInfo(food: food),
      tapHandler: () => _navigateToFoodDetailScreen(context, food: food));

  Widget _foodRow(
    BuildContext context, {
    required Widget image,
    required Widget info,
    required Function tapHandler,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => tapHandler(),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image,
                SizedBox(width: 16),
                info,
              ],
            ),
          ),
        ),
      );

  Widget _foodImage({required ImageProvider image}) => ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        height: 72.0,
        width: 72.0,
        fit: BoxFit.cover,
        image: image,
      ));

  Widget _foodInfo({required Food food}) => Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Text(food.detail),
                    ]),
                Text(
                  food.price.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ])));

  Cart _cart(BuildContext context) => Provider.of<Cart>(context, listen: false);

  Future<bool> _promptRestaurantChangeDialog(BuildContext context) async =>
      await showDialog(
              context: context, builder: (context) => RestaurantChangeDialog())
          .then((value) => value ?? false);

  Future<void> _navigateToFoodDetailScreen(
    BuildContext context, {
    required Food food,
  }) async {
    Cart cart = _cart(context);

    if (!cart.isCartBelongToRestaurant(restaurant)) {
      bool proceedToNewRestaurant =
          await _promptRestaurantChangeDialog(context);

      if (proceedToNewRestaurant) {
        cart.empty();
      } else
        return;
    }

    cart.restaurant = restaurant;

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FoodDetailScreen(food: food)));
  }
}
