import 'package:flutter/material.dart';

class RestaurantChangeDialog extends StatelessWidget {
  const RestaurantChangeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _dialog(
        title: "Change Restaurant?",
        content: "If you proceed, your cart will be cleared.",
        buttons: [
          _cancelButton(
            label: "cancel",
            tapHandler: () => Navigator.pop(context, false),
          ),
          _proceedButton(
            label: "proceed",
            tapHandler: () => Navigator.pop(context, true),
          )
        ],
      );

  Widget _dialog({
    required String title,
    required String content,
    required List<Widget> buttons,
  }) =>
      AlertDialog(title: Text(title), content: Text(content), actions: buttons);

  Widget _cancelButton({required String label, required Function tapHandler}) =>
      TextButton(
        onPressed: () => tapHandler(),
        child: Text(label),
      );

  Widget _proceedButton(
          {required String label, required Function tapHandler}) =>
      TextButton(
        onPressed: () => tapHandler(),
        child: Text(label),
      );
}
