import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:x_o_game/game/game_board/view/screens/game_board_screen.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'dart:math';
import 'dart:developer';

import 'package:x_o_game/shared/managers/var_manager.dart';

class FlippingCoinScreen extends StatefulWidget {
  static const String routeName = 'flipping-coin';
  const FlippingCoinScreen({super.key});

  @override
  State<FlippingCoinScreen> createState() => _FlippingCoinScreenState();
}

class _FlippingCoinScreenState extends State<FlippingCoinScreen> {
  String _result = 'Flipping Coin ..........';
  bool _animate = true;

  String flipCoin() {
    final random = Random();
    return random.nextBool() ? 'Heads' : 'Tails';
  }

  Future<void> flip() async {
    setState(() {
      _result = 'Flipping Coin ..........';
      _animate = true;
    });

    await Future.delayed(Duration(milliseconds: 2600));

    setState(() {
      _result = flipCoin();
      _animate = false;
      if (_result == 'Heads') {
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
    Navigator.of(context).pushReplacementNamed(
      GameBoardScreen.routeName,
      arguments: {
        'playerOneName': VarManager.playerOneName,
        'playerTwoName': VarManager.playerTwoName,
        'PlayerOneSymbol': VarManager.playerOneSymbol,
        'PlayerTwoSymbol': VarManager.playerTwoSymbol,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    flipThenNavigate();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String screenName = args['screenFromName']!;
    // final String playerOneName = args['playerOneName']!;

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
                      CupertinoIcons.arrow_left,
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
                'Coin Flip!',
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
                    '${VarManager.playerOneName} uses',
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
                    'if heads, otherwise',
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
