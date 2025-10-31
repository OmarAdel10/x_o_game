abstract class GameBoardState {}

class GameBoardInitial extends GameBoardState {
  final List<String> gameBoard;
  final int round;

  GameBoardInitial() : gameBoard = List.filled(9, ''), round = 1;
}

class GameBoardPress extends GameBoardState {
  final List<String> gameBoard;
  final int round;

  GameBoardPress({required this.gameBoard, required this.round});
}

class GameBoardWin extends GameBoardState {
  final List<String> gameBoard;
  final String winnerSymbol;

  GameBoardWin({required this.gameBoard, required this.winnerSymbol});
}

class GameBoardTies extends GameBoardState {
  final List<String> gameBoard;

  GameBoardTies({required this.gameBoard});
}
