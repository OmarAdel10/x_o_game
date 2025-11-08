// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:x_o_game/shared/apptheme.dart';

class RecentGamesModel extends Equatable {
  final String modeName;
  final String gameResult;
  final DateTime gameDate;
  final Color gameResultColor;

  const RecentGamesModel({
    required this.modeName,
    required this.gameResult,
    required this.gameDate,
    required this.gameResultColor,
  });

  @override
  List<Object?> get props => [modeName, gameResult, gameDate, gameResultColor];

  RecentGamesModel copyWith({
    String? modeName,
    String? gameResult,
    DateTime? gameDate,
    Color? gameResultColor,
  }) {
    return RecentGamesModel(
      modeName: modeName ?? this.modeName,
      gameResult: gameResult ?? this.gameResult,
      gameDate: gameDate ?? this.gameDate,
      gameResultColor: gameResultColor ?? this.gameResultColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modeName': modeName,
      'gameResult': gameResult,
      'gameDate': gameDate.millisecondsSinceEpoch,
      'gameResultColor' : gameResultColor.value,
    };
  }

  factory RecentGamesModel.fromMap(Map<String, dynamic> map) {
    return RecentGamesModel(
      modeName: map['modeName'] as String,
      gameResult: map['gameResult'] as String,
      gameDate: DateTime.fromMillisecondsSinceEpoch(map['gameDate'] as int),
      gameResultColor: Color(map['gameResultColor'] as int) ?? Apptheme.silver,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentGamesModel.fromJson(String source) =>
      RecentGamesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
