import 'package:food_delivery/models/restaurant.dart';

class RestaurantFacade {
  Future<List<Restaurant>> fetchRestaurants() async {
    return [
      Restaurant("1", "Momo Paradise1"),
      Restaurant("2", "Momo Paradise2"),
      Restaurant("3", "Momo Paradise3"),
      Restaurant("4", "Momo Paradise4"),
      Restaurant("5", "Momo Paradise5"),
      Restaurant("6", "Momo Paradise6"),
      Restaurant("7", "Momo Paradise7"),
      Restaurant("8", "Momo Paradise8"),
      Restaurant("9", "Momo Paradise9"),
    ];
  }
}
