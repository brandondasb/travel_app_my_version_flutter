import 'package:flutter/material.dart';
import 'package:travel_app_my_version/services/auth_service.dart';

class Provider extends InheritedWidget {
  final AuthService auth;

  Provider({Key? key, required Widget child, required this.auth})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider);
}
