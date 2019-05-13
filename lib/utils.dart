
import 'package:almaty_bus/design/circular_progress_reveal_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showLoadingDialog({BuildContext context, Color color}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      /*return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(title),
        content: Text(text),
        contentTextStyle: ModernTextTheme.secondary,
        actions: actions,
      );*/ 

      return Center(child: CircularProgressRevealWidget(color: color));
    },
  );
}

class SharedPreferencesManager {
  static SharedPreferences instance;

  static initialize() async {
    instance = await SharedPreferences.getInstance();
  }
}