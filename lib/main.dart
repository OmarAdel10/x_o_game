import 'package:flutter/material.dart';
import 'package:x_o_game/game/pvb/view/screens/player_vs_bot_screen.dart';
import 'package:x_o_game/game/pvp/view/screens/player_vs_player_screen.dart';
import 'package:x_o_game/home/home/view/screens/home_screen.dart';
import 'package:x_o_game/home/settings/view/screens/settings_screen.dart';
import 'package:x_o_game/home/statistics/view/screens/statistics_screen.dart';
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
        PlayerVsPlayerScreen.routeName: (_) => PlayerVsPlayerScreen(),
        PlayerVsBotScreen.routeName: (_) => PlayerVsBotScreen(),
        SettingsScreen.routeName: (_) => SettingsScreen(),
        StatisticsScreen.routeName: (_) => StatisticsScreen()
      },
      initialRoute: HomeScreen.routeName,
      theme: Apptheme.darkTheme,
    );
  }
}