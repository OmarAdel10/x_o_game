import 'package:flutter/material.dart';
import 'package:x_o_game/game/game_board/viewModel/game_board_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o_game/shared/managers/var_manager.dart';

class GameBoardCubit extends Cubit<GameBoardState> {
  GameBoardCubit() : super(GameBoardInitial());

  List<String> gameBoard = List.filled(9, '');
  int round = 1;

  void onCellPressed(int index) async {
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

  void navToHome(){
    VarManager.playerOneScore = 0;
    VarManager.playerTwoScore = 0;
    VarManager.tiesScore = 0;
    VarManager.botScore = 0;
  }
}
