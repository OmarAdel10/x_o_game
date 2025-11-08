// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:x_o_game/home/statistics/data/models/recent_games_model.dart';

class StatisticsModel extends Equatable {
  final int totalGames;
  final int draws;
  final int playerVsPlayer;
  final int playerVsBot;
  final int easyModeTotalGames;
  final int easyModeWins;
  final int mediumModeTotalGames;
  final int mediumModeWins;
  final int hardModeTotalGames;
  final int hardModeWins;
  final List<RecentGamesModel> recentGames;

  const StatisticsModel({
    required this.totalGames,
    required this.draws,
    required this.playerVsPlayer,
    required this.playerVsBot,
    required this.easyModeTotalGames,
    required this.easyModeWins,
    required this.mediumModeTotalGames,
    required this.mediumModeWins,
    required this.hardModeTotalGames,
    required this.hardModeWins,
    required this.recentGames,
  });

  StatisticsModel copyWith({
    int? totalGames,
    int? draws,
    int? playerVsPlayer,
    int? playerVsBot,
    int? easyModeTotalGames,
    int? easyModeWins,
    int? meduimModeTotalGames,
    int? mediumModeWins,
    int? hardModeTotalGames,
    int? hardModeWins,
    List<RecentGamesModel>? recentGames,
  }) {
    return StatisticsModel(
      totalGames: totalGames ?? this.totalGames,
      draws: draws ?? this.draws,
      playerVsPlayer: playerVsPlayer ?? this.playerVsPlayer,
      playerVsBot: playerVsBot ?? this.playerVsBot,
      easyModeTotalGames: easyModeTotalGames ?? this.easyModeTotalGames,
      easyModeWins: easyModeWins ?? this.easyModeWins,
      mediumModeTotalGames: meduimModeTotalGames ?? mediumModeTotalGames,
      mediumModeWins: mediumModeWins ?? this.mediumModeWins,
      hardModeTotalGames: hardModeTotalGames ?? this.hardModeTotalGames,
      hardModeWins: hardModeWins ?? this.hardModeWins,
      recentGames: recentGames ?? this.recentGames,
    );
  }

  @override
  List<Object?> get props => [
    totalGames,
    draws,
    playerVsPlayer,
    playerVsBot,
    easyModeTotalGames,
    easyModeWins,
    mediumModeTotalGames,
    mediumModeWins,
    hardModeTotalGames,
    hardModeWins,
    recentGames,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalGames': totalGames,
      'draws': draws,
      'playerVsPlayer': playerVsPlayer,
      'playerVsBot': playerVsBot,
      'easyModeTotalGames' : easyModeTotalGames,
      'easyModeWins': easyModeWins,
      'meduimModeTotalGames' : mediumModeTotalGames,
      'mediumModeWins': mediumModeWins,
      'hardModeTotalGames' : hardModeTotalGames,
      'hardModeWins': hardModeWins,
      'recentGames': recentGames
          .map((recentGame) => recentGame.toMap())
          .toList(),
    };
  }

  factory StatisticsModel.fromMap(Map<String, dynamic> map) {
    return StatisticsModel(
      totalGames: map['totalGames'] as int,
      draws: map['draws'] as int,
      playerVsPlayer: map['playerVsPlayer'] as int,
      playerVsBot: map['playerVsBot'] as int,
      easyModeTotalGames: map['easyModeTotalGames'] as int,
      easyModeWins: map['easyModeWins'] as int,
      mediumModeTotalGames: map['meduimModeTotalGames'] as int,
      mediumModeWins: map['mediumModeWins'] as int,
      hardModeTotalGames: map['hardModeTotalGames'] as int,
      hardModeWins: map['hardModeWins'] as int,
      recentGames: List<RecentGamesModel>.from(
        (map['recentGames'] as List).map<RecentGamesModel>(
          (recentGames) =>
              RecentGamesModel.fromMap(recentGames as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatisticsModel.fromJson(String source) =>
      StatisticsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
