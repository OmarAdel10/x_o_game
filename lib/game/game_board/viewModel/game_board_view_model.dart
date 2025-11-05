import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_events.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_states.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';

class GameBoardBloc extends Bloc<GameBoardEvents, GameBoardState> {
  bool isPlayerVsBot = false;
  String playerOneSymbol = '';
  String playerTwoSymbolOrBot = '';
  List<String> gameBoard = List.filled(9, '');
  int round = 1;
  int playerOneScore = 0;
  int playerTwoScore = 0;
  int botScore = 0;
  int tiesScore = 0;

  GameBoardBloc()
    : super(GameBoardInitial(round: 1, gameBoard: List.filled(9, ''))) {
    on<GameBoardInitialEvent>((event, emit) {
      try {
        if (event.p1Symbol != '' && event.p2Symbol != '') {
          playerOneSymbol = event.p1Symbol;
          playerTwoSymbolOrBot = event.p2Symbol;
        } else {
          throw Exception('Players Symbols are Empty');
        }

        if (event.screenName != null && event.screenName!.isNotEmpty) {
          isPlayerVsBot = event.screenName == VarManager.playerVsBotScreenName;
        } else {
          throw Exception('Failed to identify game mode');
        }

        add(GameBoardReset());
      } catch (e) {
        dev.log('failed to initGame : $e');
        emit(GameBoardError(message: 'failed to initGame : $e'));
      }
    });

    on<GameBoardBotMoveEvent>((event, emit) async {
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
        await Future.delayed(Duration(seconds: 1));
        gameBoard[botMoveIndex] = playerTwoSymbolOrBot;

        if (checkWinnerCustom(gameBoard, playerTwoSymbolOrBot)) {
          add(GameBoardHandleWining(playerTwoSymbolOrBot));
          return;
        }

        round++;
        emit(GameBoardPressState(round: round, gameBoard: gameBoard));

        if (round == 10) add(const GameBoardHandleTies());
      }
    });

    on<GameBoardHandleWining>((event, emit) async {
      
      if (isPlayerVsBot) {
        if (event.winnerSymbol == playerOneSymbol) {
          playerOneScore++;
        } else {
          botScore++;
        }
      } else {
        if (event.winnerSymbol == playerOneSymbol) {
          playerOneScore++;
        } else {
          playerTwoScore++;
        }
      }

      emit(GameBoardWin(winnerSymbol: event.winnerSymbol));
      await Future.delayed(Duration(seconds: 1));
      add(const GameBoardReset());
    });

    on<GameBoardHandleTies>((event, emit) async {
      tiesScore++;
      emit(const GameBoardTies());
      await Future.delayed(Duration(seconds: 1));
      add(const GameBoardReset());
    });

    on<GameBoardPress>((event, emit) async {
      // Game Press Logic
      String currentSymbol = round.isOdd ? 'x' : 'o';
      if (gameBoard[event.index].isNotEmpty) {
        emit(const GameBoardError(message: 'Wrong!, Filled Cell\nTry again.'));
        return;
      }

      // PvP Logic
      gameBoard[event.index] = currentSymbol;

      // Check Winning
      if (checkWinnerCustom(gameBoard, currentSymbol)) {
        add(GameBoardHandleWining(currentSymbol));
        return;
      }

      round++;
      emit(GameBoardPressState(gameBoard: gameBoard, round: round));

      // If Ties( Draw )
      if (round == 10) {
        add(const GameBoardHandleTies());
        return;
      }

      // Bot Logic
      if (isPlayerVsBot) {
        add(const GameBoardBotMoveEvent());
      }
    });

    on<GameBoardNavToHome>((event, emit) {
      _resetGameData();
      emit(GameBoardInitial(gameBoard: List.filled(9, ''), round: 1));
    });

    on<GameBoardReset>((event, emit) {
      gameBoard = List.filled(9, '');
      round = 1;
      emit(GameBoardInitial(gameBoard: List.filled(9, ''), round: 1));
      if (isPlayerVsBot && playerTwoSymbolOrBot == 'x') {
        add(const GameBoardBotMoveEvent());
      }
    });
  }

  void _resetGameData() {
    dev.log('Resetting game data - Previous state: ${state.runtimeType}');

    // Reset scores
    final previousScores = {
      'player1': playerOneScore,
      'player2': playerTwoScore,
      'ties': tiesScore,
      'bot': botScore,
    };
    dev.log('Previous scores: $previousScores');

    playerOneScore = 0;
    playerTwoScore = 0;
    tiesScore = 0;
    botScore = 0;

    // Reset game settings
    dev.log('Resetting bot mode from: ${VarManager.botMode}');
    VarManager.botMode = 0;

    // Reset player information
    dev.log(
      'Resetting player info - P1: ${VarManager.playerOneName}, P2: ${VarManager.playerTwoName}',
    );
    VarManager.playerOneName = '';
    VarManager.playerTwoName = '';
    VarManager.playerOneSymbol = '';
    VarManager.playerTwoSymbol = '';

    // Reset bloc state
    playerOneSymbol = '';
    playerTwoSymbolOrBot = '';
    isPlayerVsBot = false;
    round = 1;
    gameBoard = List.filled(9, '');

    dev.log('Game data reset completed');
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
    int winMove = _findWinningMove(playerTwoSymbolOrBot);
    if (winMove != -1) return winMove;

    int blockMove = _findWinningMove(playerOneSymbol);
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
    int winMove = _findWinningMove(playerTwoSymbolOrBot);
    if (winMove != -1) return winMove;
    int blockMove = _findWinningMove(playerOneSymbol);
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
      boardCopy[i] = playerTwoSymbolOrBot;
      int score = minimax(
        boardCopy,
        0,
        false,
        playerTwoSymbolOrBot,
        playerOneSymbol,
      );

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
    num alpha = -double.infinity,
    num beta = double.infinity,
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
        final List<String> boardCopy = List.from(gameBoard);
        boardCopy[i] = symbol;
        if (checkWinnerCustom(boardCopy, symbol)) return i;
      }
    }
    return -1;
  }

  // bool isBotTurn() {}
}
