import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class FlippingCoinScreen extends StatelessWidget {
  static const String routeName = 'flipping-coin';
  const FlippingCoinScreen({super.key});

  final String _result = 'Flipping Coin ..........';
  final bool _animate = true;
  @override
  Widget build(BuildContext context) {
    final String screenCommingFromName =
        ModalRoute.of(context)!.settings.arguments as String;
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
                    screenCommingFromName,
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
                    'Player 1 uses',
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
