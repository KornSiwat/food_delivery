import 'package:flutter/material.dart';
import 'package:food_delivery/src/models/food.dart';

class FoodInfo extends StatelessWidget {
  const FoodInfo({Key? key, required this.food}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) {
    return _foodInfo(
      image: _image(imageUrl: food.imageUrl),
      info: _info(name: food.name, price: food.price.toString()),
    );
  }

  Widget _foodInfo({
    required Widget image,
    required Widget info,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      image,
      info,
    ]);
  }

  Widget _image({required String imageUrl}) {
    return imageUrl.isEmpty
        ? Image(
            height: 240,
            image: AssetImage('images/foods/default_food.jpeg'),
            fit: BoxFit.cover,
          )
        : Image.network(
            imageUrl,
            height: 240,
            fit: BoxFit.cover,
          );
  }

  Widget _info({required String name, required String price}) => Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              price,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: 12),
        Text(
          food.detail,
          style: TextStyle(fontSize: 20),
        )
      ]));
}
