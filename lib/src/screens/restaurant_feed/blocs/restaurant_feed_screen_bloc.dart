import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/repositories/restaurant_repository.dart';

part 'restaurant_feed_screen_state.dart';
part 'restaurant_feed_screen_event.dart';

typedef _Event = RestaurantFeedScreenEvent;
typedef _State = RestaurantFeedScreenState;

class RestaurantFeedScreenBloc extends Bloc<_Event, _State> {
  RestaurantFeedScreenBloc(this.repository) : super(InitialState());

  final RestaurantRepository repository;

  @override
  Stream<_State> mapEventToState(_Event event) async* {
    if (event is StartedEvent) {
      yield* _mapStartedToState(event);
    } else if (event is DataLoadedEvent) {
      yield* _mapDataLoadedToState(event);
    } else if (event is ErrorOccurredEvent) {
      yield LoadFailureState(event.error);
    } else if (event is DataLoadingRetriedEvent) {
      yield* _mapDataLoadingRetriedToState();
    }
  }

  Stream<_State> _mapStartedToState(StartedEvent event) async* {
    yield LoadInProgressState();

    _fetchRestaurants();
  }

  Stream<_State> _mapDataLoadedToState(DataLoadedEvent event) async* {
    yield LoadSuccessState(restaurants: event.restaurants);
  }

  Stream<_State> _mapDataLoadingRetriedToState() async* {
    yield LoadInProgressState();

    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      final List<Restaurant> restaurants = await repository.fetchRestaurants();
      add(DataLoadedEvent(restaurants: restaurants));
    } on Exception catch (error) {
      add(ErrorOccurredEvent(error));
    }
  }
}
