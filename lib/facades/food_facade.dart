import 'package:food_delivery/models/food.dart';

class FoodFacade {
  Future<List<Food>> fetchFoods(String storeID) async {
    final prices = {
      "1": [
        Food("1", "Momo1 Food1", "cooks daily", 30),
        Food("2", "Momo1 Food2", "cooks daily", 30),
        Food("3", "Momo1 Food3", "cooks daily", 20),
        Food("4", "Momo1 Food4", "cooks daily", 16),
        Food("5", "Momo1 Food5", "cooks daily", 14),
        Food("6", "Momo1 Food6", "cooks daily", 25),
        Food("7", "Momo1 Food7", "cooks daily", 80)
      ],
      "2": [
        Food("1", "Momo2 Food1", "cooks daily", 30),
        Food("2", "Momo2 Food2", "cooks daily", 30),
        Food("3", "Momo2 Food3", "cooks daily", 20),
        Food("4", "Momo2 Food4", "cooks daily", 16),
        Food("5", "Momo2 Food5", "cooks daily", 14),
        Food("6", "Momo2 Food6", "cooks daily", 25),
        Food("7", "Momo2 Food7", "cooks daily", 80)
      ],
    };

    return prices[storeID] ?? [];
  }
}
