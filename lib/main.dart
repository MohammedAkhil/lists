import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:lists/auth/auth.controller.dart';
import 'package:lists/get_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ListsApp());
}

const _primaryColor = Color(0xFF6200EE);

ThemeData darkTheme = ThemeData(
  primaryColor: _primaryColor,
  highlightColor: Colors.transparent,
  colorScheme: const ColorScheme(
    primary: _primaryColor,
    primaryVariant: Color(0xFF3700B3),
    secondary: Color(0xFF03DAC6),
    secondaryVariant: Color(0xFF018786),
    background: Colors.white,
    surface: Colors.white,
    onBackground: Colors.black,
    error: Color(0xFFB00020),
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),
  dividerTheme: const DividerThemeData(
    thickness: 1,
    color: Color(0xFFE5E5E5),
  ),
);

class ListsApp extends StatelessWidget {
  final AuthController authController =
      Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lists',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GetMaterialApp(
        defaultTransition: Transition.cupertino,
        getPages: AppRoutes.routes,
        initialRoute: '/',
      ),
    );
  }
}
