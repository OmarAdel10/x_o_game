import 'package:flutter/material.dart';
import 'package:x_o_game/Home/view/screens/home_screen.dart';
import 'package:x_o_game/shared/apptheme.dart';

void main() {
  runApp(const XOGame());
}

class XOGame extends StatelessWidget {
  const XOGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: Apptheme.darkTheme,
    );
  }
}