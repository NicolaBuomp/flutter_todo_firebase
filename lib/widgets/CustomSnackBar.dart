import 'package:flutter/material.dart';
class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    required Color backgroundColor,
    required String text,
    required VoidCallback onAction,
  }) : super(
    backgroundColor: backgroundColor,
    content: Text(text),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: onAction,
    ),
  );
}