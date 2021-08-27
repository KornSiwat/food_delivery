import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key, required this.title, required this.content, required this.floatingActionButton}) : super(key: key);

  final String title;
  final Widget content;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return _screen(
      tapHandler: _collapseKeyboard,
      appBar: _appBar(title: title),
      content: content,
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _screen({
    required Function tapHandler,
    required AppBar appBar,
    required Widget content,
    required Widget? floatingActionButton,
  }) {
    return GestureDetector(
      onTap: () => tapHandler(),
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(child: content),
        floatingActionButton: floatingActionButton,
      ),
    );
  }

  AppBar _appBar({required String title}) {
    return AppBar(
      title: Text(title),
    );
  }

  void _collapseKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
