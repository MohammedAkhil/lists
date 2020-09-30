import 'package:get/get.dart';
import 'package:lists/auth/views/login.dart';
import 'package:lists/auth/views/register.dart';
import 'package:lists/home.dart';
import 'package:lists/splashscreen.dart';
import 'package:lists/today.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/',
      page: () =>Today (),
    ),
  ];
}
