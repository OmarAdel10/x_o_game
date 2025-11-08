import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:x_o_game/game/flipping_coin/view/screens/flipping_coin_screen.dart';
import 'package:x_o_game/game/game_board/view/screens/game_board_screen.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_view_model.dart';
import 'package:x_o_game/game/pvb/view/screens/player_vs_bot_screen.dart';
import 'package:x_o_game/game/pvp/view/screens/player_vs_player_screen.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/home/view/screens/home_screen.dart';
import 'package:x_o_game/home/settings/view/screens/settings_screen.dart';
import 'package:x_o_game/home/settings/viewModel/settings_states.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/home/statistics/view/screens/statistics_screen.dart';
import 'package:x_o_game/home/statistics/viewModel/statistics_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  // Debug logs to help troubleshoot StorageNotFound issues
  log('HydratedStorage built: ${storage.runtimeType}');

  HydratedBloc.storage = storage;
  log('HydratedBloc.storage has been set.');

  runApp(const XOGame());
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class XOGame extends StatelessWidget {
  const XOGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => StatisticsBloc()),
      ],
      child: BlocProvider(
        create: (context) =>
            GameBoardBloc(statBloc: context.read<StatisticsBloc>()),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorObservers: [routeObserver],
              debugShowCheckedModeBanner: false,
              locale: Locale(state.model.language),
              routes: {
                HomeScreen.routeName: (_) => const HomeScreen(),
                PlayerVsPlayerScreen.routeName: (_) => PlayerVsPlayerScreen(),
                PlayerVsBotScreen.routeName: (_) => PlayerVsBotScreen(),
                SettingsScreen.routeName: (_) => const SettingsScreen(),
                StatisticsScreen.routeName: (_) => const StatisticsScreen(),
                FlippingCoinScreen.routeName: (_) => const FlippingCoinScreen(),
                GameBoardScreen.routeName: (_) => const GameBoardScreen(),
              },
              initialRoute: HomeScreen.routeName,
              theme: Apptheme.darkTheme,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            );
          },
        ),
      ),
    );
  }
}
