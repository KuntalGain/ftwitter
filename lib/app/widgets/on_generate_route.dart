import 'package:flutter/material.dart';
import 'package:ftwitter/app/screens/login_screen.dart';
import 'package:ftwitter/app/screens/register_screen.dart';
import 'package:ftwitter/constant.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.signUpPage:
        {
          return routeBuilder(const RegisterScreen());
        }
      case PageConst.signInPage:
        {
          return routeBuilder(const LoginScreen());
        }
    }
    return null;
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (ctx) => child);
}
