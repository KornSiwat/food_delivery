part of 'restaurant_feed_screen_bloc.dart';

abstract class RestaurantFeedScreenEvent {}

class StartedEvent extends _Event {}

class DataLoadedEvent extends _Event {
  DataLoadedEvent({required this.restaurants});

  final List<Restaurant> restaurants;
}

class ErrorOccurredEvent extends _Event {
  ErrorOccurredEvent(this.error);

  final Exception error;
}

class DataLoadingRetriedEvent extends _Event {}
