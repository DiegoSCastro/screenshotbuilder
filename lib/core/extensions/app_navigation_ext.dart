import 'package:flutter/material.dart';


extension AppNavigationExt on BuildContext {

  void push(Widget nextScreen) {
    Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => nextScreen,
    ));
  }

  void pushReplacement(Widget nextScreen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(
      builder: (context) => nextScreen,
    ));
  }

  void pushAndRemoveUntil(Widget nextScreen) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false,
    );
  }

  void popScreen() {
    Navigator.of(this).pop();
  }
}


