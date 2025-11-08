import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/home/statistics/view/widgets/bot_challenge_container_item.dart';
import 'package:x_o_game/home/statistics/view/widgets/overall_stats_container_item.dart';
import 'package:x_o_game/home/statistics/view/widgets/recent_games_container_item.dart';
import 'package:x_o_game/home/statistics/viewModel/statistics_states.dart';
import 'package:x_o_game/home/statistics/viewModel/statistics_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class StatisticsScreen extends StatefulWidget {
  static const String routeName = 'statistics';
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

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
                          localization.game_statistics,
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
                // Overall Stats Card
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
                            horizontal: 24,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.moving,
                                    size: 24,
                                    color: Apptheme.lightBlue,
                                  ),
                                  const SizedBox(width: 8),
                                  AutoSizeText(
                                    localization.overall_stats,
                                    style: GoogleFonts.roboto(
                                      color: Apptheme.silver,
                                      fontSize: FontSizeManager.sectionTitle,
                                      fontWeight:
                                          FontWeightManager.sectionTitles,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child:
                                        BlocBuilder<
                                          StatisticsBloc,
                                          StatisticsState
                                        >(
                                          builder: (context, state) {
                                            return OverallStatsContainerItem(
                                              statNumber:
                                                  state.model.totalGames,
                                              statText:
                                                  localization.total_games,
                                            );
                                          },
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child:
                                        BlocBuilder<
                                          StatisticsBloc,
                                          StatisticsState
                                        >(
                                          builder: (context, state) {
                                            return OverallStatsContainerItem(
                                              statNumber: state.model.draws,
                                              statText: localization.draws,
                                            );
                                          },
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child:
                                        BlocBuilder<
                                          StatisticsBloc,
                                          StatisticsState
                                        >(
                                          builder: (context, state) {
                                            return OverallStatsContainerItem(
                                              statNumber:
                                                  state.model.playerVsPlayer,
                                              statText: localization.pvp_games,
                                              statNumberColor:
                                                  Apptheme.lightBlue,
                                            );
                                          },
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child:
                                        BlocBuilder<
                                          StatisticsBloc,
                                          StatisticsState
                                        >(
                                          builder: (context, state) {
                                            return OverallStatsContainerItem(
                                              statNumber:
                                                  state.model.playerVsBot,
                                              statText: localization.vs_bot,
                                              statNumberColor:
                                                  Apptheme.lightYellow,
                                            );
                                          },
                                        ),
                                  ),
                                ],
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

                const SizedBox(height: 32),
                // Bot Challenge Stats Card
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
                            horizontal: 24,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.rosette,
                                    size: 24,
                                    color: Apptheme.lightYellow,
                                  ),
                                  const SizedBox(width: 8),
                                  AutoSizeText(
                                    localization.bot_challenge_stats,
                                    style: GoogleFonts.roboto(
                                      color: Apptheme.silver,
                                      fontSize: FontSizeManager.sectionTitle,
                                      fontWeight:
                                          FontWeightManager.sectionTitles,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              BlocBuilder<StatisticsBloc, StatisticsState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      BotChallengeContainerItem(
                                        modeText: localization.easy,
                                        winingPercentNumber:
                                            state.model.easyModeTotalGames > 0
                                            ? ((state.model.easyModeWins /
                                                          state
                                                              .model
                                                              .easyModeTotalGames) *
                                                      100)
                                                  .toInt()
                                            : 0,
                                        totalGamesInThisMode:
                                            state.model.easyModeTotalGames,
                                        totalWiningsInThisMode:
                                            state.model.easyModeWins,
                                      ),
                                      BotChallengeContainerItem(
                                        modeText: localization.medium,
                                        winingPercentNumber:
                                            state.model.mediumModeTotalGames > 0
                                            ? ((state.model.mediumModeWins /
                                                          state
                                                              .model
                                                              .mediumModeTotalGames) *
                                                      100)
                                                  .toInt()
                                            : 0,
                                        totalGamesInThisMode:
                                            state.model.mediumModeTotalGames,
                                        totalWiningsInThisMode:
                                            state.model.mediumModeWins,
                                      ),
                                      BotChallengeContainerItem(
                                        modeText: localization.hard,
                                        winingPercentNumber:
                                            state.model.hardModeTotalGames > 0
                                            ? ((state.model.hardModeWins /
                                                          state
                                                              .model
                                                              .hardModeTotalGames) *
                                                      100)
                                                  .toInt()
                                            : 0,
                                        totalGamesInThisMode:
                                            state.model.hardModeTotalGames,
                                        totalWiningsInThisMode:
                                            state.model.hardModeWins,
                                      ),
                                    ],
                                  );
                                },
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

                const SizedBox(height: 32),
                // Recent Games Card
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
                            horizontal: 24,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 24,
                                    color: Apptheme.silver,
                                  ),
                                  const SizedBox(width: 8),
                                  AutoSizeText(
                                    localization.recent_games,
                                    style: GoogleFonts.roboto(
                                      color: Apptheme.silver,
                                      fontSize: FontSizeManager.sectionTitle,
                                      fontWeight:
                                          FontWeightManager.sectionTitles,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              BlocBuilder<StatisticsBloc, StatisticsState>(
                                builder: (context, state) {
                                  return state.model.recentGames.isNotEmpty
                                      ? SizedBox(
                                          height:
                                              state.model.recentGames.length ==
                                                  3
                                              ? MediaQuery.sizeOf(
                                                      context,
                                                    ).height *
                                                    0.25
                                              : MediaQuery.sizeOf(
                                                      context,
                                                    ).height *
                                                    0.3,
                                          child: ScrollbarTheme(
                                            data: ScrollbarThemeData(
                                              interactive: false,
                                              thickness:
                                                  WidgetStateProperty.all(1),
                                              thumbColor:
                                                  WidgetStateProperty.all(
                                                    Apptheme.silver.withValues(
                                                      alpha: 0.4,
                                                    ),
                                                  ),
                                              radius: const Radius.circular(10),
                                              minThumbLength: 3,
                                              mainAxisMargin: 4,
                                              crossAxisMargin: -1,
                                            ),
                                            child: Scrollbar(
                                              controller: scrollController,
                                              thumbVisibility: true,
                                              child: ListView.separated(
                                                controller: scrollController,
                                                itemBuilder: (_, index) =>
                                                    RecentGamesContainerItem(
                                                      model: state
                                                          .model
                                                          .recentGames[index],
                                                    ),
                                                separatorBuilder: (_, index) =>
                                                    const SizedBox(height: 5),
                                                itemCount: state
                                                    .model
                                                    .recentGames
                                                    .length,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
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

                SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
