import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:x_o_game/game/game_board/view/screens/game_board_screen.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'dart:math';

import 'package:x_o_game/shared/managers/var_manager.dart';

class FlippingCoinScreen extends StatefulWidget {
  static const String routeName = 'flipping-coin';
  const FlippingCoinScreen({super.key});

  @override
  State<FlippingCoinScreen> createState() => _FlippingCoinScreenState();
}

class _FlippingCoinScreenState extends State<FlippingCoinScreen> {
  String _result = '';
  bool _animate = true;
  late String screenName;

  String flipCoin() {
    final localization = S.of(context);
    final random = Random();
    return random.nextBool() ? localization.heads : localization.tails;
  }

  Future<void> flip() async {
    final localization = S.of(context);
    setState(() {
      _result = localization.flipping_coin;
      _animate = true;
    });

    await Future.delayed(Duration(milliseconds: 2600));

    setState(() {
      _result = flipCoin();
      _animate = false;
      if (_result == localization.heads) {
        VarManager.playerOneSymbol = 'x';
        VarManager.playerTwoSymbol = 'o';
      } else {
        VarManager.playerOneSymbol = 'o';
        VarManager.playerTwoSymbol = 'x';
      }
    });
  }

  Future<void> flipThenNavigate() async {
    await flip();

    await Future.delayed(Duration(seconds: 1));
    if (mounted) {
      context.pushReplacementTransition(
        type: PageTransitionType.fade,
        child: GameBoardScreen(),
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300),
        settings: RouteSettings(arguments: {'screenName': screenName}),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      flipThenNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    screenName = args['screenFromName']!;

    final localization = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(
                      context.read<SettingsBloc>().state.model.language == 'en'
                          ? CupertinoIcons.arrow_left
                          : CupertinoIcons.arrow_right,
                      size: 24,
                      color: Apptheme.silver,
                    ),
                  ),
                  const SizedBox(width: 20),
                  AutoSizeText(
                    screenName,
                    style: GoogleFonts.roboto(
                      color: Apptheme.silver,
                      fontSize: FontSizeManager.header,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              AutoSizeText(
                localization.coin_flip,
                style: GoogleFonts.roboto(
                  color: Apptheme.silver,
                  fontSize: FontSizeManager.subheader,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
              const SizedBox(height: 8),
              // Player 1 uses X if heads, otherwise O Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '${VarManager.playerOneName} ${localization.uses}',
                    style: GoogleFonts.roboto(
                      color: Apptheme.silver,
                      fontSize: FontSizeManager.bodyMedium,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                  Image.asset(
                    AssetsManager.x,
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                  AutoSizeText(
                    localization.if_heads,
                    style: GoogleFonts.roboto(
                      color: Apptheme.silver,
                      fontSize: FontSizeManager.bodyMedium,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                  Image.asset(
                    AssetsManager.o,
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                ],
              ),

              Lottie.asset(AssetsManager.flippingCoin, animate: _animate),

              AutoSizeText(
                _result,
                style: GoogleFonts.roboto(
                  color: Apptheme.silver,
                  fontSize: FontSizeManager.subheader,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
