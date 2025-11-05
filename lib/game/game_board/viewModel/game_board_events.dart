// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class GameBoardEvents {
  const GameBoardEvents();
}

class GameBoardInitialEvent extends GameBoardEvents {
  final String p1Symbol;
  final String p2Symbol;
  final String? screenName;

  const GameBoardInitialEvent({
    required this.p1Symbol,
    required this.p2Symbol,
    required this.screenName,
  });
}

class GameBoardPress extends GameBoardEvents {
  final int index;

  const GameBoardPress(this.index);
}

class GameBoardBotMoveEvent extends GameBoardEvents {
  const GameBoardBotMoveEvent();
}

class GameBoardHandleWining extends GameBoardEvents {
  final String winnerSymbol;

  const GameBoardHandleWining(this.winnerSymbol);
}

class GameBoardHandleTies extends GameBoardEvents {
  const GameBoardHandleTies();
}

class GameBoardNavToHome extends GameBoardEvents {
  const GameBoardNavToHome();
}

class GameBoardReset extends GameBoardEvents {
  const GameBoardReset();
}
