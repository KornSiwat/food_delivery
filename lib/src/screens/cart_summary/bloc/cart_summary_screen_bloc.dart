import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';

part 'cart_summary_screen_state.dart';
part 'cart_summary_screen_event.dart';

typedef _Event = CartSummaryScreenEvent;
typedef _State = CartSummaryScreenState;

class CartSummaryScreenBloc extends Bloc<_Event, _State> {
  CartSummaryScreenBloc(this.cartCubit) : super(InitialState());

  final CartCubit cartCubit;

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
    _fetchCart();
  }

  Stream<_State> _mapDataLoadedToState(DataLoadedEvent event) async* {
    yield LoadSuccessState(event.cart);
  }

  Stream<_State> _mapDataLoadingRetriedToState() async* {
    yield LoadInProgressState();
    _fetchCart();
  }

  void _fetchCart() {
    try {
      final Cart cart = cartCubit.state;

      add(DataLoadedEvent(cart));
    } on Exception catch (error) {
      add(ErrorOccurredEvent(error));
    }
  }
}
