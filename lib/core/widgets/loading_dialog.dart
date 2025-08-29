import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext? context) {
    if (context == null) return;

    if (!Navigator.of(context, rootNavigator: true).mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) {
        return const PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext? context) {
    if (context == null) return;
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }
}
