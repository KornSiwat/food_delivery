part of 'cart_summary_screen_bloc.dart';

abstract class CartSummaryScreenEvent {}

class StartedEvent extends _Event {}

class DataLoadedEvent extends _Event {
  DataLoadedEvent(this.cart);

  final Cart cart;
}

class ErrorOccurredEvent extends _Event {
  ErrorOccurredEvent(this.error);

  final Exception error;
}

class DataLoadingRetriedEvent extends _Event {}
