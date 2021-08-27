part of 'food_detail_screen_bloc.dart';

abstract class FoodDetailScreenEvent {}

class StartedEvent extends _Event {}

class DataLoadedEvent extends _Event {
  DataLoadedEvent(this.foodItem);

  FoodItem foodItem;
}

class DecreaseQuantityEvent extends _Event {}

class IncreaseQuantityEvent extends _Event {}

class UpdateNoteEvent extends _Event {
  UpdateNoteEvent(this.note);

  String note;
}

class AddToCartEvent extends _Event {
  AddToCartEvent(this.foodItem);

  FoodItem foodItem;
}

class RemoveFromCartEvent extends _Event {
  RemoveFromCartEvent(this.foodItem);

  FoodItem foodItem;
}

class DataLoadingRetriedEvent extends _Event {}
