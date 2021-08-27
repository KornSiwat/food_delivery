import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/app/cubits/cart_cubit.dart';
import 'package:food_delivery/src/models/cart.dart';
import 'package:food_delivery/src/screens/cart_summary/bloc/cart_summary_screen_bloc.dart';
import 'package:food_delivery/src/screens/cart_summary/widgets/delivery_info_section.dart';
import 'package:food_delivery/src/screens/cart_summary/widgets/foot_item_list.dart';
import 'package:food_delivery/src/screens/cart_summary/widgets/order_button.dart';
import 'package:food_delivery/src/screens/cart_summary/widgets/payment_section.dart';
import 'package:food_delivery/src/screens/cart_summary/widgets/price_summary_section.dart';
import 'package:food_delivery/src/screens/common/widgets/loading_indicator.dart';
import 'package:food_delivery/src/screens/common/widgets/screen.dart';

class CartSummaryScreen extends StatelessWidget {
  CartSummaryScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, Cart>(
      builder: (context, state) {
        return Screen(
          title: _title(context),
          content: _content(context),
          floatingActionButton: _floatingActionButton(context),
        );
      },
    );
  }

  String _title(BuildContext context) {
    return "Cart Summary";
  }

  Widget _content(BuildContext context) {
    return BlocProvider(
      create: (_) => CartSummaryScreenBloc(context.read<CartCubit>()),
      child: BlocBuilder<CartSummaryScreenBloc, CartSummaryScreenState>(
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
    CartSummaryScreenState state,
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
    CartSummaryScreenState state,
  ) {
    context.read<CartSummaryScreenBloc>().add(StartedEvent());

    return Container();
  }

  Widget _mapLoadInProgressStateToContent(
    BuildContext context,
    CartSummaryScreenState state,
  ) {
    return LoadingIndicator();
  }

  Widget _mapLoadSuccessStateToContent(
    BuildContext context,
    LoadSuccessState state,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView(
            children: [
              DeliveryInfoSection(restaurant: state.cart.restaurant!),
              FoodItemSection(foodItems: state.cart.foodItems),
              PaymentSection(),
              PriceSummarySection(cart: state.cart),
            ],
          ),
        ),
        OrderButton(),
      ],
    );
  }

  Widget _mapLoadFailureStateToContent(
    BuildContext context,
    CartSummaryScreenState state,
  ) {
    context.read<CartSummaryScreenBloc>().add(DataLoadingRetriedEvent());

    return Container();
  }
}
