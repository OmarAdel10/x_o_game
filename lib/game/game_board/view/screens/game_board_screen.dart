import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/game/game_board/view/widgets/grid_container_item.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_states_cubit.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_view_model_cubit.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/home/view/screens/home_screen.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';
import 'package:x_o_game/shared/widgets/custom_button.dart';

class GameBoardScreen extends StatefulWidget {
  static const String routeName = 'game';
  const GameBoardScreen({super.key});

  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String screenName = args['screenName']!;

    final cubit = context.read<GameBoardCubit>();
    cubit.initGame(screenName);

    return BlocListener<GameBoardCubit, GameBoardState>(
      listener: (context, state) {
        final cubit = context.read<GameBoardCubit>();

        if (state is GameBoardWin) {
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
                      state.winnerSymbol == VarManager.playerOneSymbol
                          ? '${VarManager.playerOneName} ${localization.game_wins}'
                          : '${VarManager.playerTwoName} ${localization.game_wins}',
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
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName)
                                  .then((_) => cubit.navToHome());
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
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName)
                                  .then((_) => cubit.navToHome());
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
        }
      },
      child: BlocBuilder<GameBoardCubit, GameBoardState>(
        builder: (context, state) {
          final cubit = context.read<GameBoardCubit>();

          List<String> gameBoard = [];
          int round = 1;

          if (state is GameBoardInitial) {
            gameBoard = state.gameBoard;
            round = state.round;
          } else if (state is GameBoardPress) {
            gameBoard = state.gameBoard;
            round = state.round;
          } else if (state is GameBoardWin) {
            gameBoard = state.gameBoard;
            round = cubit.round;
          } else if (state is GameBoardTies) {
            gameBoard = state.gameBoard;
            round = cubit.round;
          }

          final bool disableGrid = cubit.isBotTurn;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.routeName)
                                  .then((_) => cubit.navToHome());
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
                                          fontSize: FontSizeManager.caption,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                        ),
                                      ),
                                Image.asset(
                                  round.isOdd
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
                                          fontSize: FontSizeManager.caption,
                                          fontWeight:
                                              FontWeightManager.semiBold,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => cubit.resetGame(),
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
                      ),

                      const SizedBox(height: 32),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        child: IgnorePointer(
                          ignoring: disableGrid,
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
                            itemBuilder: (_, indx) => GridContainerItem(
                              symbol: gameBoard[indx],
                              index: indx,
                              onPressed: cubit.onCellPressed,
                            ),
                            itemCount: 9,
                          ),
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
                                        0.066,
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
                                  Text(
                                    '${VarManager.playerOneScore}',
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
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height *
                                        0.066,
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
                                  Text(
                                    '${VarManager.tiesScore}',
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
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.sizeOf(context).height *
                                        0.066,
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
                                          screenName ==
                                                  VarManager
                                                      .playerVsPlayerScreenName
                                              ? VarManager.playerTwoName
                                              : VarManager.botName,
                                          maxLines: 1,
                                          minFontSize: FontSizeManager.caption,
                                          style: GoogleFonts.roboto(
                                            color: Apptheme.lightYellow,
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
                                  Text(
                                    '${screenName == VarManager.playerVsPlayerScreenName ? VarManager.playerTwoScore : VarManager.botScore}',
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
            ),
          );
        },
      ),
    );
  }
}
