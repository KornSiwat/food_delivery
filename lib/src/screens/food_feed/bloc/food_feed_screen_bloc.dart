import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/repositories/food_repository.dart';

part 'food_feed_screen_state.dart';
part 'food_feed_screen_event.dart';

typedef _Event = FoodFeedScreenEvent;
typedef _State = FoodFeedScreenState;

class FoodFeedScreenBloc extends Bloc<_Event, _State> {
  FoodFeedScreenBloc(
    this.repository,
    this.restaurant,
  ) : super(InitialState());

  final FoodRepository repository;
  final Restaurant restaurant;

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

    _fetchFoods();
  }

  Stream<_State> _mapDataLoadedToState(DataLoadedEvent event) async* {
    yield LoadSuccessState(event.foods);
  }

  Stream<_State> _mapDataLoadingRetriedToState() async* {
    yield LoadInProgressState();

    _fetchFoods();
  }

  Future<void> _fetchFoods() async {
    try {
      final List<Food> foods = await repository.fetchFoods(restaurant.id);

      add(DataLoadedEvent(foods));
    } on Exception catch (error) {
      add(ErrorOccurredEvent(error));
    }
  }
}
