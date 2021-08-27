import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/src/models/food_item.dart';
import 'package:food_delivery/src/screens/food_detail/blocs/food_detail_screen_bloc.dart';

class OrderPanel extends StatelessWidget {
  const OrderPanel({Key? key, required this.foodItem}) : super(key: key);
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return _orderPanel(
      noteField: _noteField(
        placeholder: "example: no vegetables",
        content: foodItem.note,
        onChanged: (note) => _updateNote(context, note),
      ),
      quantityControlPanel: _quantityControlPanel(
        decreaseButton: _decreaseQuantityButton(context),
        quantity: _quantityText(),
        increaseButton: _increaseQuantityButton(context),
      ),
      foodItemActionButton: _isQuantityMoreThanZero()
          ? _addToCartButton(
              label: "add to cart ${_totalPrice()}",
              tapHandler: () => _addToCart(context),
            )
          : _cancelOrderButton(
              label: "cancel order",
              tapHandler: () => _cancelOrder(context),
            ),
    );
  }

  Widget _orderPanel({
    required Widget noteField,
    required Widget quantityControlPanel,
    required Widget foodItemActionButton,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              noteField,
              quantityControlPanel,
            ],
          ),
          foodItemActionButton
        ],
      ),
    );
  }

  Widget _noteField({
    String label = "Note",
    String placeholder = "",
    String content = "",
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child: TextField(
              onChanged: (note) => onChanged(note),
              decoration: InputDecoration(
                hintText: content.isEmpty ? placeholder : content,
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            )),
          ],
        )
      ]),
    );
  }

  Widget _quantityControlPanel({
    required Widget decreaseButton,
    required Widget quantity,
    required Widget increaseButton,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      decreaseButton,
      SizedBox(width: 16),
      quantity,
      SizedBox(width: 16),
      increaseButton,
    ]);
  }

  Widget _quantityControlButton({
    required IconData icon,
    required Color color,
    double size = 40,
    required Function tapHandler,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => tapHandler(),
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }

  Widget _decreaseQuantityButton(BuildContext context) {
    return _quantityControlButton(
      icon: Icons.remove_circle_outline_outlined,
      color: _isQuantityMoreThanZero()
          ? Colors.red.shade400
          : Colors.grey.shade400,
      tapHandler: () =>
          _isQuantityMoreThanZero() ? _decreaseQuantity(context) : null,
    );
  }

  Widget _quantityText() {
    return Text(
      foodItem.quantity.toString(),
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.red.shade400,
      ),
    );
  }

  Widget _increaseQuantityButton(BuildContext context) {
    return _quantityControlButton(
      icon: Icons.add_circle_outline_outlined,
      color: Colors.red.shade400,
      tapHandler: () => _increaseQuantity(context),
    );
  }

  Widget foodItemActionButton({
    required String label,
    required Function tapHandler,
  }) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
          onPressed: () => tapHandler(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 20),
            ),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent)),
    ));
  }

  Widget _addToCartButton({
    String label = "add to cart",
    required Function tapHandler,
  }) {
    return foodItemActionButton(label: label, tapHandler: tapHandler);
  }

  Widget _cancelOrderButton({
    String label = "cancel order",
    required Function tapHandler,
  }) {
    return foodItemActionButton(label: label, tapHandler: tapHandler);
  }

  bool _isQuantityMoreThanZero() {
    return foodItem.quantity > 0;
  }

  void _decreaseQuantity(BuildContext context) {
    context.read<FoodDetailScreenBloc>().add(DecreaseQuantityEvent());
  }

  void _increaseQuantity(BuildContext context) {
    context.read<FoodDetailScreenBloc>().add(IncreaseQuantityEvent());
  }

  void _updateNote(BuildContext context, String note) {
    context.read<FoodDetailScreenBloc>().add(UpdateNoteEvent(note));
  }

  int _totalPrice() {
    return foodItem.food.price * foodItem.quantity;
  }

  void _addToCart(BuildContext context) {
    context.read<FoodDetailScreenBloc>().add(AddToCartEvent(foodItem));

    Navigator.pop(context);
  }

  void _cancelOrder(BuildContext context) {
    context.read<FoodDetailScreenBloc>().add(RemoveFromCartEvent(foodItem));

    Navigator.pop(context);
  }
}
