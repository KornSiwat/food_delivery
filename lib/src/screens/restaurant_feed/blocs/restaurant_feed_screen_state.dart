part of 'restaurant_feed_screen_bloc.dart';

abstract class RestaurantFeedScreenState {}

class InitialState extends _State {}

class LoadInProgressState extends _State {}

class LoadSuccessState extends _State {
  LoadSuccessState({required this.restaurants});

  final List<Restaurant> restaurants;
}

class LoadFailureState extends _State {
  LoadFailureState(this.error);

  final Exception error;
}
