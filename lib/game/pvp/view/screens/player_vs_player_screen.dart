import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/game/flipping_coin/view/screens/flipping_coin_screen.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'package:x_o_game/shared/widgets/custom_button.dart';
import 'package:x_o_game/shared/widgets/custom_text_field.dart';

class PlayerVsPlayerScreen extends StatelessWidget {
  static const String routeName = 'pvp';
  PlayerVsPlayerScreen({super.key});

  final TextEditingController playerOneNameController = TextEditingController();
  final TextEditingController playerTwoNameController = TextEditingController();

  final String screenName = 'Player Setup';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field Can Not Be Empty';
                              }
                              if (value.length < 3) {
                                return 'Name Can Not Be Less Than 3 Characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),
                          Text(
                            'Player 2 Name',
                            style: GoogleFonts.roboto(
                              color: Apptheme.silver,
                              fontSize: FontSizeManager.bodySmall,
                              fontWeight: FontWeightManager.regular,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: playerTwoNameController,
                            hintText: 'Enter Name ( or play as Guest)',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field Can Not Be Empty';
                              }
                              if (value.length < 3) {
                                return 'Name Can Not Be Less Than 3 Characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),
                          CustomButton(
                            hasPrefixIcon: true,
                            icon: CupertinoIcons.play,
                            backgroundColor: Apptheme.lightYellow,
                            shadowColor: Apptheme.shadowYellow,
                            text: 'Flip Coin & Start',
                            onPressed: () => Navigator.of(
                              context,
                            ).pushNamed(FlippingCoinScreen.routeName, arguments: screenName),
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
    );
  }
}
