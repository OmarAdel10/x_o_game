import 'package:equatable/equatable.dart';
import 'package:x_o_game/home/statistics/data/models/statistics_model.dart';

sealed class StatisticsState extends Equatable {
  final StatisticsModel model;

  const StatisticsState({required this.model});

  @override
  List<Object?> get props => [model];
}

class StatisticsInitial extends StatisticsState {
  const StatisticsInitial({required super.model});

  @override
  List<Object?> get props => [model];
}

class StatisticsUpdate extends StatisticsState {
  const StatisticsUpdate({required super.model});

  @override
  List<Object?> get props => [model];
}

class StatisticsError extends StatisticsState {
  final String message;
  const StatisticsError({required super.model, required this.message});

  @override
  List<Object?> get props => [model, message];
}
