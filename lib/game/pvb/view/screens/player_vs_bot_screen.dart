import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/game/flipping_coin/view/screens/flipping_coin_screen.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';
import 'package:x_o_game/shared/widgets/custom_button.dart';
import 'package:x_o_game/shared/widgets/custom_text_field.dart';

class PlayerVsBotScreen extends StatefulWidget {
  static const String routeName = 'pvb';
  const PlayerVsBotScreen({super.key});

  @override
  State<PlayerVsBotScreen> createState() => _PlayerVsBotScreenState();
}

class _PlayerVsBotScreenState extends State<PlayerVsBotScreen> {
  final TextEditingController playerOneNameController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final difficultyModeContainerEmojis = ['😊', '🤔', '😤', '😈'];
    final difficultyModeContainerQuotes = [
      '"I\'ll go easy on you!"',
      '"This should be fun!"',
      '"Prepare yourself!"',
      '"You asked for it.... 😈"',
    ];
    final sliderLabels = ['Easy', 'Medium', 'Hard', 'Extreme'];
    final double min = 0;
    final double max = sliderLabels.length - 1.0;
    final int divisions = sliderLabels.length - 1;

    final GlobalKey<FormState> formKey = GlobalKey();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
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
                      VarManager.playerVsBotScreenName,
                      style: GoogleFonts.roboto(
                        color: Apptheme.silver,
                        fontSize: FontSizeManager.header,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Form(
                  key: formKey,
                  child: Card(
                    elevation: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Apptheme.semiDarkNavy,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                            color: Apptheme.shadowDark,
                            offset: const Offset(0, 8),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Player 1 Name',
                                    style: GoogleFonts.roboto(
                                      color: Apptheme.silver,
                                      fontSize: FontSizeManager.bodySmall,
                                      fontWeight: FontWeightManager.regular,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  CustomTextField(
                                    controller: playerOneNameController,
                                    hintText: 'Enter Name ( or play as Guest)',
                                  ),

                                  const SizedBox(height: 16),
                                  Text(
                                    'Bot Difficulty',
                                    style: GoogleFonts.roboto(
                                      color: Apptheme.silver,
                                      fontSize: FontSizeManager.bodySmall,
                                      fontWeight: FontWeightManager.regular,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),

                            SliderTheme(
                              data: SliderThemeData(
                                activeTickMarkColor: Colors.transparent,
                                activeTrackColor: Apptheme.deepDarkNavy,
                                inactiveTickMarkColor: Colors.transparent,
                                inactiveTrackColor: Apptheme.deepDarkNavy,
                                thumbColor: Apptheme.lightBlue,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 15,
                                ),
                                valueIndicatorColor: Colors.transparent,
                                trackHeight: 30,
                              ),
                              child: Slider(
                                value: _currentIndex.toDouble(),
                                min: min,
                                max: max,
                                divisions: divisions,
                                onChanged: (value) {
                                  setState(() {
                                    _currentIndex = value.toInt();
                                    log('currentIndex: $_currentIndex');
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: sliderLabels
                                        .map(
                                          (label) => Text(
                                            label,
                                            style: GoogleFonts.roboto(
                                              color: Apptheme.silver,
                                              fontSize: FontSizeManager.tiny,
                                              fontWeight:
                                                  FontWeightManager.light,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),

                                  const SizedBox(height: 16),

                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Apptheme.deepDarkNavy,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          difficultyModeContainerEmojis[_currentIndex],
                                          style: TextStyle(fontSize: 40),
                                        ),
                                        Text(
                                          sliderLabels[_currentIndex],
                                          style: GoogleFonts.roboto(
                                            color: Apptheme.silver,
                                            fontSize: FontSizeManager.bodyLarge,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                        Text(
                                          difficultyModeContainerQuotes[_currentIndex],
                                          style: GoogleFonts.roboto(
                                            color: Apptheme.silver,
                                            fontSize: FontSizeManager.caption,
                                            fontWeight: FontWeightManager.light,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  CustomButton(
                                    hasPrefixIcon: true,
                                    icon: CupertinoIcons.play,
                                    backgroundColor: Apptheme.lightYellow,
                                    shadowColor: Apptheme.shadowYellow,
                                    text: 'Flip Coin & Start',
                                    onPressed: () {
                                      VarManager.playerOneName =
                                          playerOneNameController.text.isEmpty
                                          ? 'Player 1'
                                          : playerOneNameController.text;
                                      Navigator.of(context).pushNamed(
                                        FlippingCoinScreen.routeName,
                                        arguments: {
                                          'screenFromName':
                                              VarManager.playerVsBotScreenName,
                                          'playerOneName':
                                              playerOneNameController
                                                  .text
                                                  .isEmpty
                                              ? 'Player 1'
                                              : playerOneNameController.text,
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
