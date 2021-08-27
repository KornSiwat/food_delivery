part of 'food_feed_screen_bloc.dart';

abstract class FoodFeedScreenState {}

class InitialState extends _State {}

class LoadInProgressState extends _State {}

class LoadSuccessState extends _State {
  LoadSuccessState(this.foods);

  List<Food> foods;
}

class LoadFailureState extends _State {
  LoadFailureState(this.error);

  final Exception error;
}
