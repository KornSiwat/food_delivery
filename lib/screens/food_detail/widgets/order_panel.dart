import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/food_order.dart';
import 'package:provider/provider.dart';

class OrderPanel extends StatefulWidget {
  const OrderPanel({Key? key, required this.foodOrder}) : super(key: key);
  final FoodOrder foodOrder;

  @override
  _OrderPanelState createState() => _OrderPanelState(foodOrder);
}

class _OrderPanelState extends State<OrderPanel> {
  _OrderPanelState(this._foodOrder);
  final FoodOrder _foodOrder;

  @override
  Widget build(BuildContext context) => _orderPanel(
        noteField: _noteField(placeholder: "example: no vegetables"),
        quantityControlPanel: _quantityControlPanel(
          decreaseButton: _decreaseQuantityButton(),
          quantity: _quantityText(),
          increaseButton: _increaseQuantityButton(),
        ),
        foodOrderActionButton: _isQuantityMoreThanZero()
            ? _addToCartButton(
                label: "add to cart ${_totalPrice()}",
                tapHandler: () => _addToCart(context),
              )
            : _cancelOrderButton(
                label: "cancel order",
                tapHandler: () => _cancelOrder(context),
              ),
      );

  Widget _orderPanel({
    required Widget noteField,
    required Widget quantityControlPanel,
    required Widget foodOrderActionButton,
  }) =>
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                noteField,
                quantityControlPanel,
              ],
            ),
            foodOrderActionButton
          ],
        ),
      );

  Widget _noteField({String label = "Note", String placeholder = ""}) =>
      Padding(
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
                onChanged: (note) => setState(() => _foodOrder.note = note),
                decoration: InputDecoration(
                  hintText: placeholder,
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

  Widget _quantityControlPanel({
    required Widget decreaseButton,
    required Widget quantity,
    required Widget increaseButton,
  }) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        decreaseButton,
        SizedBox(width: 16),
        quantity,
        SizedBox(width: 16),
        increaseButton,
      ]);

  Widget _quantityControlButton({
    required IconData icon,
    required Color color,
    double size = 40,
    required Function tapHandler,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => tapHandler(),
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      );

  Widget _decreaseQuantityButton() => _quantityControlButton(
        icon: Icons.remove_circle_outline_outlined,
        color: _isQuantityMoreThanZero()
            ? Colors.red.shade400
            : Colors.grey.shade400,
        tapHandler: () =>
            _isQuantityMoreThanZero() ? _decreaseQuantity() : null,
      );

  Widget _quantityText() => Text(
        _foodOrder.quantity.toString(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade400,
        ),
      );

  Widget _increaseQuantityButton() => _quantityControlButton(
        icon: Icons.add_circle_outline_outlined,
        color: Colors.red.shade400,
        tapHandler: () => _increaseQuantity(),
      );

  Widget _foodOrderActionButton({
    required String label,
    required Function tapHandler,
  }) =>
      Center(
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

  Widget _addToCartButton({
    String label = "add to cart",
    required Function tapHandler,
  }) =>
      _foodOrderActionButton(label: label, tapHandler: tapHandler);

  Widget _cancelOrderButton({
    String label = "cancel order",
    required Function tapHandler,
  }) =>
      _foodOrderActionButton(label: label, tapHandler: tapHandler);

  void _decreaseQuantity() => setState(() => _foodOrder.quantity--);

  bool _isQuantityMoreThanZero() => (_foodOrder.quantity > 0);

  void _increaseQuantity() => setState(() => _foodOrder.quantity++);

  int _totalPrice() => (_foodOrder.food.price * _foodOrder.quantity);

  void _addToCart(BuildContext context) {
    _syncFoodOrderWithCart(context);
  }

  void _cancelOrder(BuildContext context) {
    _syncFoodOrderWithCart(context);
  }

  void _syncFoodOrderWithCart(BuildContext context) {
    Cart cart = Provider.of<Cart>(context, listen: false);

    _isQuantityMoreThanZero()
        ? cart.update(_foodOrder)
        : cart.removeFoodOrder(_foodOrder.food.id);

    Navigator.pop(context);
  }
}
