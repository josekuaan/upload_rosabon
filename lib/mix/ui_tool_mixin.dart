import 'package:flutter/material.dart';

mixin UiToolMixin {
  void showMessage(String message, BuildContext context,
      {Color color = Colors.green}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 1000),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
