import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/home/statistics/view/widgets/bot_challenge_container_item.dart';
import 'package:x_o_game/home/statistics/view/widgets/overall_stats_container_item.dart';
import 'package:x_o_game/home/statistics/view/widgets/recent_games_container_item.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class StatisticsScreen extends StatefulWidget {
  static const String routeName = 'statistics';
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final List<Widget> recentItems = [
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Player 2',
      gameDate: '10/3/2025',
      gameResult: 'Draw',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Player 2',
      gameDate: '10/3/2025',
      gameResult: 'Player 2 Won',
      gameResultColor: Apptheme.lightBlue,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Player 2',
      gameDate: '10/3/2025',
      gameResult: 'Player 1 Won',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Player 2',
      gameDate: '10/3/2025',
      gameResult: 'Player 2 Won',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Player 2',
      gameDate: '10/3/2025',
      gameResult: 'Player 1 Won',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Bot',
      gameDate: '10/3/2025',
      gameResult: 'Bot Won',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Bot',
      gameDate: '10/3/2025',
      gameResult: 'Draw',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Bot',
      gameDate: '10/3/2025',
      gameResult: 'Player 1 Won',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Bot',
      gameDate: '10/3/2025',
      gameResult: 'Player 1 Won',
      gameResultColor: Apptheme.silver,
    ),
    RecentGamesContainerItem(
      modeName: 'Player 1 vs Bot',
      gameDate: '10/3/2025',
      gameResult: 'Player 1 Won',
      gameResultColor: Apptheme.silver,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                        CupertinoIcons.arrow_left,
                        size: 24,
                        color: Apptheme.silver,
                      ),
                    ),
                    const SizedBox(width: 20),
                    AutoSizeText(
                      'Game Statistics',
                      style: GoogleFonts.roboto(
                        color: Apptheme.silver,
                        fontSize: FontSizeManager.header,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ],
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
                                'Overall Stats',
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.sectionTitle,
                                  fontWeight: FontWeightManager.sectionTitles,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OverallStatsContainerItem(
                                  statNumber: 28,
                                  statText: 'Total Games',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OverallStatsContainerItem(
                                  statNumber: 7,
                                  statText: 'Draws',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: OverallStatsContainerItem(
                                  statNumber: 9,
                                  statText: 'PvP Games',
                                  statNumberColor: Apptheme.lightBlue,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OverallStatsContainerItem(
                                  statNumber: 19,
                                  statText: 'vs Bot',
                                  statNumberColor: Apptheme.lightYellow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                'Bot Challenge Stats',
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.sectionTitle,
                                  fontWeight: FontWeightManager.sectionTitles,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Column(
                            children: [
                              BotChallengeContainerItem(
                                modeText: 'Easy',
                                winingPercentNumber: 0,
                                totalGamesInThisMode: 0,
                                totalWiningsInThisMode: 0,
                              ),
                              BotChallengeContainerItem(
                                modeText: 'Medium',
                                winingPercentNumber: 42,
                                totalGamesInThisMode: 8,
                                totalWiningsInThisMode: 19,
                              ),
                              BotChallengeContainerItem(
                                modeText: 'Hard',
                                winingPercentNumber: 0,
                                totalGamesInThisMode: 0,
                                totalWiningsInThisMode: 0,
                              ),
                              BotChallengeContainerItem(
                                modeText: 'Extreme',
                                winingPercentNumber: 0,
                                totalGamesInThisMode: 0,
                                totalWiningsInThisMode: 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                'Recent Games',
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.sectionTitle,
                                  fontWeight: FontWeightManager.sectionTitles,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            child: ScrollbarTheme(
                              data: ScrollbarThemeData(
                                interactive: false,
                                thickness: WidgetStateProperty.all(1),
                                thumbColor: WidgetStateProperty.all(
                                  Apptheme.silver.withValues(alpha: 0.4),
                                ),
                                radius: const Radius.circular(10),
                                minThumbLength: 3,
                                mainAxisMargin: 4,
                                crossAxisMargin: -1,
                              ),
                              child: Scrollbar(
                                thumbVisibility: true,
                                child: ListView.separated(
                                  itemBuilder: (_, index) => recentItems[index],
                                  separatorBuilder: (_, index) =>
                                      const SizedBox(height: 5),
                                  itemCount: recentItems.length,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
