part of 'food_feed_screen_bloc.dart';

abstract class FoodFeedScreenEvent {}

class StartedEvent extends _Event {}

class DataLoadedEvent extends _Event {
  DataLoadedEvent(this.foods);

  final List<Food> foods;
}

class ErrorOccurredEvent extends _Event {
  ErrorOccurredEvent(this.error);

  final Exception error;
}

class DataLoadingRetriedEvent extends _Event {}
