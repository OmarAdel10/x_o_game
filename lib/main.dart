import 'package:flutter/material.dart';
import 'package:x_o_game/game/flipping_coin/view/screens/flipping_coin_screen.dart';
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
        HomeScreen.routeName: (_) => const HomeScreen(),
        PlayerVsPlayerScreen.routeName: (_) => PlayerVsPlayerScreen(),
        PlayerVsBotScreen.routeName: (_) => const PlayerVsBotScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
        StatisticsScreen.routeName: (_) => const StatisticsScreen(),
        FlippingCoinScreen.routeName: (_) => const FlippingCoinScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: Apptheme.darkTheme,
    );
  }
}
