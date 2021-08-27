part of 'cart_summary_screen_bloc.dart';

abstract class CartSummaryScreenState {}

class InitialState extends _State {}

class LoadInProgressState extends _State {}

class LoadSuccessState extends _State {
  LoadSuccessState(this.cart);

  final Cart cart;
}

class LoadFailureState extends _State {
  LoadFailureState(this.error);

  final Exception error;
}
