import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/repositories/restaurant_repository.dart';
import 'package:food_delivery/src/screens/common/widgets/cart_floating_button.dart';
import 'package:food_delivery/src/screens/common/widgets/loading_indicator.dart';
import 'package:food_delivery/src/screens/common/widgets/screen.dart';
import 'package:food_delivery/src/screens/restaurant_feed/blocs/restaurant_feed_screen_bloc.dart';
import 'package:food_delivery/src/screens/restaurant_feed/widgets/restaurant_grid.dart';

class RestaurantFeedScreen extends StatelessWidget {
  RestaurantFeedScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Cart>(
      builder: (context, _) {
        return Screen(
          title: _title(context),
          content: _content(context),
          floatingActionButton: _floatingActionButton(context),
        );
      },
    );
  }

  String _title(BuildContext context) {
    return "Restaurants";
  }

  Widget _content(BuildContext context) {
    return BlocProvider<RestaurantFeedScreenBloc>(
      create: (_) => RestaurantFeedScreenBloc(RestaurantRepository()),
      child: BlocBuilder<RestaurantFeedScreenBloc, RestaurantFeedScreenState>(
        builder: (context, state) {
          return _mapStateToContent(context, state);
        },
      ),
    );
  }

  Widget? _floatingActionButton(BuildContext context) {
    BlocBuilder<CartCubit, Cart>(builder: (context, cart) {
      return cart.isEmpty() ? Container() : CartFloatingButton();
    });
  }

  Widget _mapStateToContent(
    BuildContext context,
    RestaurantFeedScreenState state,
  ) {
    if (state is InitialState) {
      return _mapInitialStateToContent(context, state);
    } else if (state is LoadInProgressState) {
      return _mapLoadInProgressStateToContent(context, state);
    } else if (state is LoadSuccessState) {
      return _mapLoadSuccessStateToContent(context, state);
    } else if (state is LoadFailureState) {
      return _mapLoadFailureStateToContent(context, state);
    } else {
      return Container();
    }
  }

  Widget _mapInitialStateToContent(
    BuildContext context,
    InitialState state,
  ) {
    context.read<RestaurantFeedScreenBloc>().add(StartedEvent());

    return Container();
  }

  Widget _mapLoadInProgressStateToContent(
    BuildContext context,
    LoadInProgressState state,
  ) {
    return LoadingIndicator();
  }

  Widget _mapLoadSuccessStateToContent(
    BuildContext context,
    LoadSuccessState state,
  ) {
    List<Restaurant> restaurants = state.restaurants;

    return RestaurantGrid(restaurants: restaurants);
  }

  Widget _mapLoadFailureStateToContent(
    BuildContext context,
    LoadFailureState state,
  ) {
    context.read<RestaurantFeedScreenBloc>().add(DataLoadingRetriedEvent());

    return Container();
  }
}
