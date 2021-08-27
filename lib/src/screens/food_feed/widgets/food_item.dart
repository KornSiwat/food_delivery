part of 'food_list.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({
    Key? key,
    required this.food,
    required this.restaurant,
  }) : super(key: key);

  final Food food;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return _foodItem(
      context,
      image: _foodImage(imageUrl: food.imageUrl),
      info: _foodInfo(food: food),
      tapHandler: () => _cart(context).isCartBelongToRestaurant(restaurant)
          ? _navigateToFoodDetailScreen(context)
          : _promptRestaurantChangeDialog(context),
    );
  }

  Widget _foodItem(
    BuildContext context, {
    required Widget image,
    required Widget info,
    required Function tapHandler,
  }) {
    return GestureDetector(
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
  }

  Widget _foodImage({required String imageUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              height: 72.0,
              width: 72.0,
              fit: BoxFit.cover,
            )
          : Image(
              height: 72.0,
              width: 72.0,
              fit: BoxFit.cover,
              image: AssetImage("images/foods/default_food.jpeg"),
            ),
    );
  }

  Widget _foodInfo({required Food food}) {
    return Expanded(
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    food.detail,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ]),
            Text(
              food.price.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _promptRestaurantChangeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => RestaurantChangeDialog(
        proceedHandler: () {
          _emptyCart(context);
          _navigateToFoodDetailScreen(context);
        },
      ),
    );
  }

  void _navigateToFoodDetailScreen(BuildContext context) async {
    _setCartRestaurant(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(food),
      ),
    );
  }

  Cart _cart(BuildContext context) {
    return context.read<CartCubit>().state;
  }

  void _emptyCart(BuildContext context) {
    return context.read<CartCubit>().empty();
  }

  void _setCartRestaurant(BuildContext context) {
    context.read<CartCubit>().setRestaurant(restaurant);
  }
}
