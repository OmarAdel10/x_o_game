import 'package:equatable/equatable.dart';

sealed class GameBoardState extends Equatable {
  const GameBoardState();
}

class GameBoardInitial extends GameBoardState {
  final List<String> gameBoard;
  final int round;
  const GameBoardInitial({required this.round, required this.gameBoard});

  @override
  List<Object?> get props => [gameBoard, round];
}

class GameBoardPressState extends GameBoardState {
  final List<String> gameBoard;
  final int round;
  const GameBoardPressState({required this.round, required this.gameBoard});

  @override
  List<Object?> get props => [gameBoard, round];
}

class GameBoardError extends GameBoardState {
  final String message;

  const GameBoardError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GameBoardWin extends GameBoardState {
  final String winnerSymbol;
  const GameBoardWin({required this.winnerSymbol});

  @override
  List<Object?> get props => [winnerSymbol];
}

class GameBoardTies extends GameBoardState {
  const GameBoardTies();

  @override
  List<Object?> get props => [];
}
