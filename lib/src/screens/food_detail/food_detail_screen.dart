import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/models/food.dart';
import 'package:food_delivery/src/models/food_item.dart';
import 'package:food_delivery/src/screens/common/widgets/loading_indicator.dart';
import 'package:food_delivery/src/screens/common/widgets/screen.dart';
import 'package:food_delivery/src/screens/food_detail/blocs/food_detail_screen_bloc.dart';
import 'package:food_delivery/src/screens/food_detail/widgets/food_info.dart';
import 'package:food_delivery/src/screens/food_detail/widgets/order_panel.dart';

class FoodDetailScreen extends StatelessWidget {
  FoodDetailScreen(this.food) : super();

  final Food food;

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
    return food.name;
  }

  Widget _content(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodDetailScreenBloc(
        food,
        context.read<CartCubit>(),
      ),
      child: BlocBuilder<FoodDetailScreenBloc, FoodDetailScreenState>(
        builder: (context, state) {
          return _mapStateToContent(context, state);
        },
      ),
    );
  }

  Widget? _floatingActionButton(BuildContext context) {
    return Container();
  }

  Widget _mapStateToContent(
    BuildContext context,
    FoodDetailScreenState state,
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
    FoodDetailScreenState state,
  ) {
    context.read<FoodDetailScreenBloc>().add(StartedEvent());

    return Container();
  }

  Widget _mapLoadInProgressStateToContent(
    BuildContext context,
    FoodDetailScreenState state,
  ) {
    return LoadingIndicator();
  }

  Widget _mapLoadSuccessStateToContent(
    BuildContext context,
    LoadSuccessState state,
  ) {
    FoodItem foodItem = state.foodItem;

    return Column(
      children: [
        FoodInfo(food: foodItem.food),
        OrderPanel(foodItem: foodItem),
      ],
    );
  }

  Widget _mapLoadFailureStateToContent(
    BuildContext context,
    FoodDetailScreenState state,
  ) {
    context.read<FoodDetailScreenBloc>().add(DataLoadingRetriedEvent());

    return LoadingIndicator();
  }
}
