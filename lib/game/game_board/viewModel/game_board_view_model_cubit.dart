import 'dart:math';

import 'package:x_o_game/game/game_board/viewModel/game_board_states_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';

class GameBoardCubit extends Cubit<GameBoardState> {
  GameBoardCubit() : super(GameBoardInitial());

  List<String> gameBoard = List.filled(9, '');
  int round = 1;

  bool get isBotTurn {
    if (!isPlayerVsBot) return false;
    String currentSymbol = round.isOdd ? 'x' : 'o';
    return botSymbol == currentSymbol;
  }

  bool isPlayerVsBot = false;
  String botSymbol = '';
  String playerSymbol = '';

  void initGame(String screenName) {
    isPlayerVsBot = screenName == VarManager.playerVsBotScreenName;

    if (isPlayerVsBot) {
      playerSymbol = VarManager.playerOneSymbol;
      botSymbol = VarManager.playerTwoSymbol;
    }

    if (isPlayerVsBot && botSymbol == 'x') {
      _botMove();
    }
  }

  void onCellPressed(int index) async {
    if (gameBoard[index].isNotEmpty) return;

    String currentSymbol = round.isOdd ? 'x' : 'o';
    if (isPlayerVsBot && currentSymbol != playerSymbol) return;

    gameBoard[index] = currentSymbol;

    // Check Winning
    if (checkWinner(currentSymbol)) {
      _handleWin(currentSymbol);
      return;
    }

    round++;
    emit(GameBoardPress(gameBoard: gameBoard, round: round));

    // If Ties( Draw )
    if (round == 10) {
      _handleTie();
      return;
    }

    if (isPlayerVsBot && currentSymbol != botSymbol) {
      await Future.delayed(Duration(milliseconds: 500));
      _botMove();
    }
  }

  void _botMove() async {
    if (round > 9) return;

    int botMoveIndex = -1;

    switch (VarManager.botMode) {
      case 0:
        botMoveIndex = _easyMode();
        break;
      case 1:
        botMoveIndex = _mediumMode();
        break;
      case 2:
        botMoveIndex = _hardMode();
        break;
    }

    if (botMoveIndex != -1 && gameBoard[botMoveIndex].isEmpty) {
      await Future.delayed(Duration(milliseconds: 500));
      gameBoard[botMoveIndex] = botSymbol;

      if (checkWinner(botSymbol)) {
        _handleWin(botSymbol);
        return;
      }

      round++;
      emit(GameBoardPress(gameBoard: gameBoard, round: round));

      if (round == 10) _handleTie();
    }
  }

  int _easyMode() {
    List<int> availableCells = [];
    for (int i = 0; i < 9; i++) {
      if (gameBoard[i].isEmpty) {
        availableCells.add(i);
      }
    }

    if (availableCells.isEmpty) return -1;

    return availableCells[Random().nextInt(availableCells.length)];
  }

  int _mediumMode() {
    int winMove = _findWinningMove(botSymbol);
    if (winMove != -1) return winMove;

    int blockMove = _findWinningMove(playerSymbol);
    if (blockMove != -1) return blockMove;

    if (gameBoard[4].isEmpty) return 4;

    List<int> corners = [0, 2, 6, 8];
    for (int corner in corners) {
      if (gameBoard[corner].isEmpty) return corner;
    }

    return _easyMode();
  }

  int _hardMode() {
    // Quick wins/blocks first
    int winMove = _findWinningMove(botSymbol);
    if (winMove != -1) return winMove;
    int blockMove = _findWinningMove(playerSymbol);
    if (blockMove != -1) return blockMove;

    // Find best move with minimax using a copy of the board
    int bestScore = -999;
    int bestMove = -1;
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (gameBoard[i].isEmpty) emptyCells.add(i);
    }

    for (int i in emptyCells) {
      // Create a copy to avoid mutating gameBoard during minimax
      List<String> boardCopy = List.from(gameBoard);
      boardCopy[i] = botSymbol;
      int score = minimax(boardCopy, 0, false, botSymbol, playerSymbol);

      if (score > bestScore) {
        bestScore = score;
        bestMove = i;
      }
    }
    return bestMove != -1 ? bestMove : _easyMode();
  }

  int minimax(
    List<String> newBoard,
    int depth,
    bool isMax,
    String botSymbol,
    String playerSymbol, [
    int alpha = -999,
    int beta = 999,
  ]) {
    // Terminal state checks
    if (checkWinnerCustom(newBoard, botSymbol)) return 10 - depth;
    if (checkWinnerCustom(newBoard, playerSymbol)) return depth - 10;
    if (!newBoard.contains('')) return 0;

    List<int> emptyCells = [];
    for (int i = 0; i < newBoard.length; i++) {
      if (newBoard[i] == '') emptyCells.add(i);
    }

    if (isMax) {
      int bestScore = -999;
      for (int i in emptyCells) {
        List<String> boardCopy = List.from(newBoard);
        boardCopy[i] = botSymbol;
        int score = minimax(
          boardCopy,
          depth + 1,
          false,
          botSymbol,
          playerSymbol,
          alpha,
          beta,
        );
        bestScore = max(score, bestScore);
        alpha = max(alpha, bestScore);
        if (beta <= alpha) break; // Alpha-beta pruning
      }
      return bestScore;
    } else {
      int bestScore = 999;
      for (int i in emptyCells) {
        List<String> boardCopy = List.from(newBoard);
        boardCopy[i] = playerSymbol;
        int score = minimax(
          boardCopy,
          depth + 1,
          true,
          botSymbol,
          playerSymbol,
          alpha,
          beta,
        );
        bestScore = min(score, bestScore);
        beta = min(beta, bestScore);
        if (beta <= alpha) break; // Alpha-beta pruning
      }
      return bestScore;
    }
  }

  /// Custom winner check that works on any board state
  bool checkWinnerCustom(List<String> board, String symbol) {
    // Check columns
    for (int i = 0; i <= 2; i++) {
      if (board[i] == symbol &&
          board[i + 3] == symbol &&
          board[i + 6] == symbol) {
        return true;
      }
    }

    // Check rows
    for (int i = 0; i <= 6; i += 3) {
      if (board[i] == symbol &&
          board[i + 1] == symbol &&
          board[i + 2] == symbol) {
        return true;
      }
    }

    // Check diagonals
    if (board[0] == symbol && board[4] == symbol && board[8] == symbol) {
      return true;
    }
    if (board[2] == symbol && board[4] == symbol && board[6] == symbol) {
      return true;
    }

    return false;
  }

  int _findWinningMove(String symbol) {
    for (int i = 0; i < 9; i++) {
      if (gameBoard[i].isEmpty) {
        gameBoard[i] = symbol;
        bool wins = checkWinner(symbol);
        gameBoard[i] = '';

        if (wins) return i;
      }
    }
    return -1;
  }

  void _handleWin(String winnerSymbol) async {
    if (isPlayerVsBot) {
      if (winnerSymbol == playerSymbol) {
        VarManager.playerOneScore++;
      } else {
        VarManager.botScore++;
      }
    } else {
      if (winnerSymbol == VarManager.playerOneSymbol) {
        VarManager.playerOneScore++;
      } else {
        VarManager.playerTwoScore++;
      }
    }

    emit(GameBoardWin(gameBoard: gameBoard, winnerSymbol: winnerSymbol));
    await Future.delayed(Duration(seconds: 1));
    clearGameBoard();
    emit(GameBoardInitial());
  }

  void _handleTie() async {
    VarManager.tiesScore++;
    emit(GameBoardTies(gameBoard: gameBoard));
    await Future.delayed(Duration(seconds: 1));
    clearGameBoard();
    emit(GameBoardInitial());
  }

  void onCellPressedOld(int index) async {
    if (gameBoard[index].isNotEmpty) return;

    String currentSymbol = round.isOdd ? 'x' : 'o';

    gameBoard[index] = currentSymbol;

    // Check Winning
    if (checkWinner(currentSymbol)) {
      if (VarManager.playerOneSymbol == currentSymbol) {
        VarManager.playerOneScore++;
      } else {
        VarManager.playerTwoScore++;
      }
      emit(GameBoardWin(gameBoard: gameBoard, winnerSymbol: currentSymbol));
      await Future.delayed(Duration(seconds: 1));
      clearGameBoard();
      emit(GameBoardInitial());
      return;
    }

    round++;
    emit(GameBoardPress(gameBoard: gameBoard, round: round));

    // If Ties( Draw )
    if (round == 10) {
      VarManager.tiesScore++;
      emit(GameBoardTies(gameBoard: gameBoard));
      await Future.delayed(Duration(seconds: 1));
      clearGameBoard();
      emit(GameBoardInitial());
    }
  }

  bool checkWinner(String symbol) {
    if (round < 5) return false;
    // 0,3,6 Vertical
    // 1,4,7 Vertical
    // 2,5,8 Vertical
    for (int i = 0; i <= 2; i++) {
      if ([i, i + 3, i + 6].every((i) => gameBoard[i] == symbol)) return true;
    }

    // 0,1,2 Horizontal
    // 3,4,5 Horizontal
    // 6,7,8 Horizontal
    for (int i = 0; i <= 6; i += 3) {
      if ([i, i + 1, i + 2].every((i) => gameBoard[i] == symbol)) return true;
    }

    // 0,4,8 Diagonal
    if ([0, 4, 8].every((i) => gameBoard[i] == symbol)) return true;
    // 2,4,6 Diagonal
    if ([2, 4, 6].every((i) => gameBoard[i] == symbol)) return true;

    return false;
  }

  void clearGameBoard() {
    gameBoard = List.filled(9, '');
    round = 1;
  }

  void resetGame() {
    clearGameBoard();
    emit(GameBoardInitial());
  }

  void navToHome() {
    VarManager.playerOneScore = 0;
    VarManager.playerTwoScore = 0;
    VarManager.tiesScore = 0;
    VarManager.botScore = 0;
    VarManager.botMode = 0;
    VarManager.playerOneName = '';
    VarManager.playerTwoName = '';
    VarManager.playerOneSymbol = '';
    VarManager.playerTwoSymbol = '';
  }
}
