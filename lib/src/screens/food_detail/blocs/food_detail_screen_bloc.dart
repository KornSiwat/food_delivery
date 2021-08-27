import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/food_item.dart';

part 'food_detail_screen_state.dart';
part 'food_detail_screen_event.dart';

typedef _Event = FoodDetailScreenEvent;
typedef _State = FoodDetailScreenState;

class FoodDetailScreenBloc extends Bloc<_Event, _State> {
  FoodDetailScreenBloc(this.food, this.cartCubit) : super(InitialState());

  final Food food;
  final CartCubit cartCubit;

  @override
  Stream<_State> mapEventToState(_Event event) async* {
    if (event is StartedEvent) {
      yield* _mapStartedToState(event);
    } else if (event is DataLoadedEvent) {
      yield* _mapDataLoadedToState(event);
    } else if (event is DecreaseQuantityEvent && state is LoadSuccessState) {
      yield* _mapDecreaseQuantityToState(event, state as LoadSuccessState);
    } else if (event is IncreaseQuantityEvent && state is LoadSuccessState) {
      yield* _mapIncreaseQuantityToState(event, state as LoadSuccessState);
    } else if (event is UpdateNoteEvent) {
      yield* _mapUpdateNoteToState(event, state as LoadSuccessState);
    } else if (event is AddToCartEvent) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCartEvent) {
      yield* _mapRemoveFromCartToState(event);
    } else if (event is DataLoadingRetriedEvent) {
      yield* _mapDataLoadingRetriedToState(event);
    }
  }

  Stream<_State> _mapStartedToState(StartedEvent event) async* {
    yield LoadInProgressState();

    _fetchFoodItem(food);
  }

  Stream<_State> _mapDataLoadedToState(DataLoadedEvent event) async* {
    yield LoadSuccessState(event.foodItem);
  }

  Stream<_State> _mapDecreaseQuantityToState(
    DecreaseQuantityEvent event,
    LoadSuccessState state,
  ) async* {
    FoodItem foodItem = state.foodItem;

    if (foodItem.quantity > 0) {
      foodItem.quantity--;
    }

    yield LoadSuccessState(foodItem);
  }

  Stream<_State> _mapIncreaseQuantityToState(
    IncreaseQuantityEvent event,
    LoadSuccessState state,
  ) async* {
    FoodItem foodItem = state.foodItem;

    foodItem.quantity++;

    yield LoadSuccessState(foodItem);
  }

  Stream<_State> _mapUpdateNoteToState(
    UpdateNoteEvent event,
    LoadSuccessState state,
  ) async* {
    FoodItem foodItem = state.foodItem;
    String note = event.note;

    foodItem.note = note;

    yield LoadSuccessState(foodItem);
  }

  Stream<_State> _mapAddToCartToState(
    AddToCartEvent event,
  ) async* {
    FoodItem foodItem = event.foodItem;

    cartCubit.addFoodItem(foodItem);

    yield InitialState();
  }

  Stream<_State> _mapRemoveFromCartToState(
    RemoveFromCartEvent event,
  ) async* {
    FoodItem foodItem = event.foodItem;

    cartCubit.remove(foodItem);

    yield InitialState();
  }

  Stream<_State> _mapDataLoadingRetriedToState(
      DataLoadingRetriedEvent event) async* {
    yield LoadInProgressState();

    _fetchFoodItem(food);
  }

  void _fetchFoodItem(Food food) {
    FoodItem foodItem = _cart().getFoodItem(food.id) ?? FoodItem(food, 1, "");

    add(DataLoadedEvent(foodItem));
  }

  Cart _cart() {
    return cartCubit.state;
  }
}
