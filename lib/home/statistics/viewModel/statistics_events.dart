import 'dart:ui';

sealed class StatisticsEvents {}

class DrawsEvent extends StatisticsEvents {}

class PlayerVsPlayerEvent extends StatisticsEvents {}

class PlayerVsBotEvent extends StatisticsEvents {}

class EasyModeTotalGamesEvent extends StatisticsEvents {}

class EasyModeWinsEvent extends StatisticsEvents {}

class MeduimModeTotalGamesEvent extends StatisticsEvents {}

class MeduimModeWinsEvent extends StatisticsEvents {}

class HardModeTotalGamesEvent extends StatisticsEvents {}

class HardModeWinsEvent extends StatisticsEvents {}

class RecentGamesEvent extends StatisticsEvents {
  final String modeName;
  final String gameResult;
  final DateTime gameDate;
  final Color gameResultColor;

  RecentGamesEvent({
    required this.modeName,
    required this.gameResult,
    required this.gameDate,
    required this.gameResultColor,
  });
}
