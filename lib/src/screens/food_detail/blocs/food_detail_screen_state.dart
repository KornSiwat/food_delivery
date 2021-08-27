part of 'food_detail_screen_bloc.dart';

abstract class FoodDetailScreenState {}

class InitialState extends _State {}

class LoadInProgressState extends _State {}

class LoadSuccessState extends _State {
  LoadSuccessState(this.foodItem);

  FoodItem foodItem;
}

class LoadFailureState extends _State {
  LoadFailureState(this.error);

  final Exception error;
}
