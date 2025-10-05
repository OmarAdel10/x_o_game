import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/game/game/view/widgets/grid_container_item.dart';
import 'package:x_o_game/home/home/view/screens/home_screen.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class GameScreen extends StatelessWidget {
  static const String routeName = 'game';
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(
                      context,
                    ).pushReplacementNamed(HomeScreen.routeName),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Apptheme.silver,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        size: 24,
                        color: Apptheme.primary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Apptheme.semiDarkNavy,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Apptheme.shadowDark,
                          offset: const Offset(0, 6),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.x,
                          width: 24,
                          height: 24,
                          fit: BoxFit.fill,
                        ),
                        AutoSizeText(
                          'TURN',
                          style: GoogleFonts.roboto(
                            color: Apptheme.silver,
                            fontSize: FontSizeManager.caption,
                            fontWeight: FontWeightManager.semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Apptheme.silver,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      CupertinoIcons.restart,
                      size: 24,
                      color: Apptheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (_, index) =>
                      const GridContainerItem(symbol: 'o'),
                  itemCount: 9,
                ),
              ),

              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Apptheme.lightBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Player 1 ( O )',
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                              color: Apptheme.primary,
                              fontSize: FontSizeManager.bodySmall,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                          Text(
                            '0',
                            style: GoogleFonts.roboto(
                              color: Apptheme.primary,
                              fontSize: FontSizeManager.mediumNumber,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Apptheme.silver,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Ties',
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                              color: Apptheme.primary,
                              fontSize: FontSizeManager.bodySmall,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                          Text(
                            '0',
                            style: GoogleFonts.roboto(
                              color: Apptheme.primary,
                              fontSize: FontSizeManager.mediumNumber,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Apptheme.lightYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Player 2 ( X )',
                            maxLines: 1,
                            style: GoogleFonts.roboto(
                              color: Apptheme.primary,
                              fontSize: FontSizeManager.bodySmall,
                              fontWeight: FontWeightManager.semiBold,
                            ),
                          ),
                          Text(
                            '0',
                            style: GoogleFonts.roboto(
                              color: Apptheme.primary,
                              fontSize: FontSizeManager.mediumNumber,
                              fontWeight: FontWeightManager.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
