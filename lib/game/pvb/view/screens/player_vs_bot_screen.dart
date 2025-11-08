import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:x_o_game/game/flipping_coin/view/screens/flipping_coin_screen.dart';
import 'package:x_o_game/game/pvb/view/widgets/difficulty_selector.dart';
import 'package:x_o_game/game/pvb/view/widgets/slider_components_widget.dart';
import 'package:x_o_game/game/pvb/view/widgets/slider_widget.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';
import 'package:x_o_game/shared/widgets/custom_button.dart';
import 'package:x_o_game/shared/widgets/custom_text_field.dart';

class PlayerVsBotScreen extends StatelessWidget {
  static const String routeName = 'pvb';
  PlayerVsBotScreen({super.key});

  final TextEditingController playerOneNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

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
                            context.read<SettingsBloc>().state.model.language ==
                                    'en'
                                ? CupertinoIcons.arrow_left
                                : CupertinoIcons.arrow_right,
                            size: 24,
                            color: Apptheme.silver,
                          ),
                        ),
                        const SizedBox(width: 20),
                        AutoSizeText(
                          localization.bot_challenge,
                          style: GoogleFonts.roboto(
                            color: Apptheme.silver,
                            fontSize: FontSizeManager.header,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(
                      begin: 0,
                      delay: Duration(milliseconds: 200),
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    )
                    .slideX(
                      begin: -0.2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: 32),
                Form(
                  key: formKey,
                  child:
                      Card(
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
                                  vertical: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            localization.player_one_name,
                                            style: GoogleFonts.roboto(
                                              color: Apptheme.silver,
                                              fontSize:
                                                  FontSizeManager.bodySmall,
                                              fontWeight:
                                                  FontWeightManager.regular,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          CustomTextField(
                                            controller: playerOneNameController,
                                            hintText: localization.enter_name,
                                          ),

                                          const SizedBox(height: 16),
                                          Text(
                                            localization.bot_difficulty,
                                            style: GoogleFonts.roboto(
                                              color: Apptheme.silver,
                                              fontSize:
                                                  FontSizeManager.bodySmall,
                                              fontWeight:
                                                  FontWeightManager.regular,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ),

                                    DifficultySelector(),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        children: [
                                          CustomButton(
                                            hasPrefixIcon: true,
                                            icon: CupertinoIcons.play,
                                            backgroundColor:
                                                Apptheme.lightYellow,
                                            shadowColor: Apptheme.shadowYellow,
                                            text: localization
                                                .flip_coin_and_start,
                                            onPressed: () {
                                              VarManager.playerOneName =
                                                  playerOneNameController
                                                      .text
                                                      .isEmpty
                                                  ? context
                                                                .read<
                                                                  SettingsBloc
                                                                >()
                                                                .state
                                                                .model
                                                                .language ==
                                                            'en'
                                                        ? 'Player 1'
                                                        : 'اللاعب 1'
                                                  : playerOneNameController
                                                        .text;

                                              context.pushNamedTransition(
                                                routeName: FlippingCoinScreen
                                                    .routeName,
                                                type: PageTransitionType.fade,
                                                curve: Curves.easeInOut,
                                                duration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                arguments: {
                                                  'screenFromName': localization
                                                      .bot_challenge,
                                                  'playerOneName':
                                                      playerOneNameController
                                                          .text
                                                          .isEmpty
                                                      ? context
                                                                    .read<
                                                                      SettingsBloc
                                                                    >()
                                                                    .state
                                                                    .model
                                                                    .language ==
                                                                'en'
                                                            ? 'Player 1'
                                                            : 'اللاعب 1'
                                                      : playerOneNameController
                                                            .text,
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
                          )
                          .animate()
                          .fadeIn(
                            begin: 0,
                            delay: Duration(milliseconds: 200),
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          )
                          .slideY(
                            begin: 0.1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
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
