import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/restaurant.dart';
import 'package:food_delivery/src/repositories/food_repository.dart';
import 'package:food_delivery/src/screens/common/widgets/cart_floating_button.dart';
import 'package:food_delivery/src/screens/common/widgets/loading_indicator.dart';
import 'package:food_delivery/src/screens/common/widgets/screen.dart';
import 'package:food_delivery/src/screens/food_feed/bloc/food_feed_screen_bloc.dart';
import 'package:food_delivery/src/screens/food_feed/widgets/food_list.dart';

class FoodFeedScreen extends StatelessWidget {
  FoodFeedScreen(this.restaurant) : super();

  final Restaurant restaurant;

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
    return restaurant.name;
  }

  Widget _content(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodFeedScreenBloc(
        FoodRepository(),
        restaurant,
      ),
      child: BlocBuilder<FoodFeedScreenBloc, FoodFeedScreenState>(
        builder: (context, state) {
          return _mapStateToContent(context, state);
        },
      ),
    );
  }

  Widget? _floatingActionButton(BuildContext context) {
    return BlocBuilder<CartCubit, Cart>(builder: (context, state) {
      Cart cart = state;

      return cart.isEmpty() ? Container() : CartFloatingButton();
    });
  }

  Widget _mapStateToContent(
    BuildContext context,
    FoodFeedScreenState state,
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
    FoodFeedScreenState state,
  ) {
    context.read<FoodFeedScreenBloc>().add(StartedEvent());

    return Container();
  }

  Widget _mapLoadInProgressStateToContent(
    BuildContext context,
    FoodFeedScreenState state,
  ) {
    return LoadingIndicator();
  }

  Widget _mapLoadSuccessStateToContent(
    BuildContext context,
    LoadSuccessState state,
  ) {
    List<Food> foods = state.foods;

    return FoodList(
      restaurant: restaurant,
      foods: foods,
    );
  }

  Widget _mapLoadFailureStateToContent(
    BuildContext context,
    FoodFeedScreenState state,
  ) {
    context.read<FoodFeedScreenBloc>().add(DataLoadingRetriedEvent());

    return Container();
  }
}
