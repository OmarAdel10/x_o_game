import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:x_o_game/game/game_board/view/widgets/grid_container_item.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_events.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_states.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_view_model.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/home/view/screens/home_screen.dart';
import 'package:x_o_game/home/settings/viewModel/settings_events.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';
import 'package:x_o_game/shared/widgets/custom_button.dart';

class GameBoardScreen extends StatelessWidget {
  static const String routeName = 'game';
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String screenName = args['screenName']!;
    context.read<GameBoardBloc>().add(
      GameBoardInitialEvent(
        p1Symbol: VarManager.playerOneSymbol,
        p2Symbol: VarManager.playerTwoSymbol,
        screenName: screenName,
      ),
    );
    return BlocListener<GameBoardBloc, GameBoardState>(
      listenWhen: (previous, current) =>
          current is GameBoardError ||
          current is GameBoardWin ||
          current is GameBoardTies ||
          current is GameBoardPressState,
      listener: (context, state) {
        final gameBloc = context.read<GameBoardBloc>();
        if (state is GameBoardError) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: state.message),
            animationDuration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            dismissType: DismissType.onSwipe,
            dismissDirection: [
              DismissDirection.horizontal,
              DismissDirection.vertical,
            ],
            displayDuration: Duration(seconds: 1),
            snackBarPosition: SnackBarPosition.top,
            padding: EdgeInsets.symmetric(horizontal: 8),
          );
        } else if (state is GameBoardWin) {
          context.read<SettingsBloc>().add(SuccessSound());
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.7),
            builder: (context) => AlertDialog(
              elevation: 20,
              backgroundColor: Apptheme.semiDarkNavy,
              content: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.18,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      localization.takes_the_round,
                      style: GoogleFonts.roboto(
                        color: Apptheme.silver,
                        fontSize: FontSizeManager.bodySmall,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                    Text(
                      '${state.winnerSymbol == VarManager.playerOneSymbol ? VarManager.playerOneName : VarManager.playerTwoName} ${localization.game_wins}',
                      style: GoogleFonts.roboto(
                        color: state.winnerSymbol == VarManager.playerOneSymbol
                            ? Apptheme.lightBlue
                            : Apptheme.lightYellow,
                        fontSize: FontSizeManager.largeHeader,
                        fontWeight: FontWeightManager.extraBold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            backgroundColor: Apptheme.silver,
                            shadowColor: Colors.transparent,
                            text: localization.quit,
                            onPressed: () {
                              context.pushReplacementTransition(
                                type: PageTransitionType.fade,
                                child: HomeScreen(),
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 300),
                              ).then(
                                    (_) => gameBloc.add(GameBoardNavToHome()),
                                  );
                            },
                            height: 42,
                            verticalPadding: 13,
                            radius: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomButton(
                            backgroundColor: Apptheme.lightYellow,
                            shadowColor: Apptheme.shadowYellow,
                            text: localization.next_round,
                            onPressed: () => Navigator.of(context).pop(),
                            height: 42,
                            verticalPadding: 13,
                            radius: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GameBoardTies) {
          context.read<SettingsBloc>().add(LoseSound());
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.7),
            builder: (context) => AlertDialog(
              elevation: 20,
              backgroundColor: Apptheme.semiDarkNavy,
              content: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      localization.round_tied,
                      style: GoogleFonts.roboto(
                        color: Apptheme.silver,
                        fontSize: FontSizeManager.largeHeader,
                        fontWeight: FontWeightManager.extraBold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            backgroundColor: Apptheme.silver,
                            shadowColor: Colors.transparent,
                            text: localization.quit,
                            onPressed: () {
                              context
                                  .pushReplacementTransition(
                                    type: PageTransitionType.fade,
                                    child: HomeScreen(),
                                    curve: Curves.easeInOut,
                                    duration: Duration(milliseconds: 300),
                                  )
                                  .then(
                                    (_) => gameBloc.add(GameBoardNavToHome()),
                                  );
                            },
                            height: 42,
                            verticalPadding: 13,
                            radius: 8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomButton(
                            backgroundColor: Apptheme.lightYellow,
                            shadowColor: Apptheme.shadowYellow,
                            text: localization.round_tied,
                            onPressed: () => Navigator.of(context).pop(),
                            height: 42,
                            verticalPadding: 13,
                            radius: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GameBoardPressState) {
          context.read<SettingsBloc>().add(ClickSound());
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<GameBoardBloc, GameBoardState>(
                            builder: (context, state) {
                              final gameBloc = context.read<GameBoardBloc>();
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(
                                        HomeScreen.routeName,
                                      )
                                      .then(
                                        (_) =>
                                            gameBloc.add(GameBoardNavToHome()),
                                      );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Apptheme.silver,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    context
                                                .read<SettingsBloc>()
                                                .state
                                                .model
                                                .language ==
                                            'en'
                                        ? CupertinoIcons.arrow_left
                                        : CupertinoIcons.arrow_right,
                                    size: 24,
                                    color: Apptheme.primary,
                                  ),
                                ),
                              );
                            },
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
                            child: BlocBuilder<GameBoardBloc, GameBoardState>(
                              builder: (context, state) {
                                return state is GameBoardWin
                                    ? AutoSizeText(
                                        localization.wins,
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.silver,
                                          fontSize: FontSizeManager.caption,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                        ),
                                      )
                                    : state is GameBoardTies
                                    ? AutoSizeText(
                                        localization.tie,
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.silver,
                                          fontSize: FontSizeManager.caption,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          context
                                                      .read<SettingsBloc>()
                                                      .state
                                                      .model
                                                      .language ==
                                                  'en'
                                              ? const SizedBox()
                                              : AutoSizeText(
                                                  localization.turn,
                                                  style: GoogleFonts.roboto(
                                                    color: Apptheme.silver,
                                                    fontSize:
                                                        FontSizeManager.caption,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .semiBold,
                                                  ),
                                                ),
                                          Image.asset(
                                            context
                                                    .read<GameBoardBloc>()
                                                    .round
                                                    .isOdd
                                                ? AssetsManager.x
                                                : AssetsManager.o,
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.fill,
                                          ),
                                          context
                                                      .read<SettingsBloc>()
                                                      .state
                                                      .model
                                                      .language ==
                                                  'en'
                                              ? AutoSizeText(
                                                  localization.turn,
                                                  style: GoogleFonts.roboto(
                                                    color: Apptheme.silver,
                                                    fontSize:
                                                        FontSizeManager.caption,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .semiBold,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      );
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.read<GameBoardBloc>().add(
                              GameBoardReset(),
                            ),
                            child: Container(
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
                      .slideY(
                        begin: -0.3,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),

                  const SizedBox(height: 32),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    child: BlocBuilder<GameBoardBloc, GameBoardState>(
                      builder: (context, state) {
                        return IgnorePointer(
                          ignoring:
                              context.read<GameBoardBloc>().isPlayerVsBot &&
                              (context.read<GameBoardBloc>().round.isOdd
                                      ? 'x'
                                      : 'o') !=
                                  context.read<GameBoardBloc>().playerOneSymbol,
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 1.0,
                                ),
                            itemBuilder: (_, indx) =>
                                BlocBuilder<GameBoardBloc, GameBoardState>(
                                  builder: (context, state) {
                                    return GridContainerItem(
                                      symbol: context
                                          .read<GameBoardBloc>()
                                          .gameBoard[indx],
                                      index: indx,
                                      onPressed: () {
                                        context.read<GameBoardBloc>().add(
                                          GameBoardPress(indx),
                                        );
                                      },
                                    );
                                  },
                                ),
                            itemCount: 9,
                          ),
                        );
                      },
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
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height *
                                        0.07,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Apptheme.semiDarkNavy,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Apptheme.shadowDark,
                                          offset: const Offset(0, 3),
                                          blurRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        AutoSizeText(
                                          VarManager.playerOneName,
                                          maxLines: 1,
                                          minFontSize: FontSizeManager.caption,
                                          style: GoogleFonts.roboto(
                                            color: Apptheme.lightBlue,
                                            fontSize: FontSizeManager.bodySmall,
                                            fontWeight:
                                                FontWeightManager.semiBold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '[ ',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                color: Apptheme.lightBlue,
                                                fontSize:
                                                    FontSizeManager.bodySmall,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                              ),
                                            ),
                                            Image.asset(
                                              VarManager.playerOneSymbol == 'x'
                                                  ? AssetsManager.x
                                                  : AssetsManager.o,
                                              width: 17,
                                              height: 17,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              ' ]',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                color: Apptheme.lightBlue,
                                                fontSize:
                                                    FontSizeManager.bodySmall,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  BlocBuilder<GameBoardBloc, GameBoardState>(
                                    builder: (context, state) {
                                      return Text(
                                        '${context.read<GameBoardBloc>().playerOneScore}',
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.primary,
                                          fontSize:
                                              FontSizeManager.mediumNumber,
                                          fontWeight: FontWeightManager.bold,
                                        ),
                                      );
                                    },
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
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height *
                                        0.07,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Apptheme.semiDarkNavy,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Apptheme.shadowDark,
                                          offset: const Offset(0, 3),
                                          blurRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: AutoSizeText(
                                        'Ties',
                                        maxLines: 1,
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.silver,
                                          fontSize: FontSizeManager.bodySmall,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  BlocBuilder<GameBoardBloc, GameBoardState>(
                                    builder: (context, state) {
                                      return Text(
                                        '${context.read<GameBoardBloc>().tiesScore}',
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.primary,
                                          fontSize:
                                              FontSizeManager.mediumNumber,
                                          fontWeight: FontWeightManager.bold,
                                        ),
                                      );
                                    },
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
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height *
                                        0.07,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Apptheme.semiDarkNavy,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Apptheme.shadowDark,
                                          offset: const Offset(0, 3),
                                          blurRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        BlocBuilder<
                                          GameBoardBloc,
                                          GameBoardState
                                        >(
                                          builder: (context, state) {
                                            return AutoSizeText(
                                              context
                                                      .read<GameBoardBloc>()
                                                      .isPlayerVsBot
                                                  ? VarManager.botName
                                                  : VarManager.playerTwoName,
                                              maxLines: 1,
                                              minFontSize:
                                                  FontSizeManager.caption,
                                              style: GoogleFonts.roboto(
                                                color: Apptheme.lightYellow,
                                                fontSize:
                                                    FontSizeManager.bodySmall,
                                                fontWeight:
                                                    FontWeightManager.semiBold,
                                              ),
                                            );
                                          },
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '[ ',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                color: Apptheme.lightYellow,
                                                fontSize:
                                                    FontSizeManager.bodySmall,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                              ),
                                            ),
                                            Image.asset(
                                              VarManager.playerTwoSymbol == 'x'
                                                  ? AssetsManager.x
                                                  : AssetsManager.o,
                                              width: 17,
                                              height: 17,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              ' ]',
                                              maxLines: 1,
                                              style: GoogleFonts.roboto(
                                                color: Apptheme.lightYellow,
                                                fontSize:
                                                    FontSizeManager.bodySmall,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  BlocBuilder<GameBoardBloc, GameBoardState>(
                                    builder: (context, state) {
                                      return Text(
                                        '${context.read<GameBoardBloc>().isPlayerVsBot ? context.read<GameBoardBloc>().botScore : context.read<GameBoardBloc>().playerTwoScore}',
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.primary,
                                          fontSize:
                                              FontSizeManager.mediumNumber,
                                          fontWeight: FontWeightManager.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
                      .slideY(
                        begin: 0.3,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
