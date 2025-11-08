import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:x_o_game/home/statistics/data/models/recent_games_model.dart';
import 'package:x_o_game/home/statistics/data/models/statistics_model.dart';
import 'package:x_o_game/home/statistics/viewModel/statistics_events.dart';
import 'package:x_o_game/home/statistics/viewModel/statistics_states.dart';

class StatisticsBloc extends HydratedBloc<StatisticsEvents, StatisticsState> {
  StatisticsBloc()
    : super(
        StatisticsInitial(
          model: StatisticsModel(
            totalGames: 0,
            draws: 0,
            playerVsPlayer: 0,
            playerVsBot: 0,
            easyModeTotalGames: 0,
            easyModeWins: 0,
            mediumModeTotalGames: 0,
            mediumModeWins: 0,
            hardModeTotalGames: 0,
            hardModeWins: 0,
            recentGames: [],
          ),
        ),
      ) {
    on<DrawsEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            draws: state.model.draws + 1,
            totalGames: state.model.totalGames + 1,
          ),
        ),
      );
    });

    on<PlayerVsPlayerEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            playerVsPlayer: state.model.playerVsPlayer + 1,
            totalGames: state.model.totalGames + 1,
          ),
        ),
      );
    });

    on<PlayerVsBotEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            playerVsBot: state.model.playerVsBot + 1,
            totalGames: state.model.totalGames + 1,
          ),
        ),
      );
    });

    on<EasyModeTotalGamesEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            easyModeTotalGames: state.model.easyModeTotalGames + 1,
          ),
        ),
      );
    });

    on<EasyModeWinsEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            easyModeWins: state.model.easyModeWins + 1,
          ),
        ),
      );
    });

    on<MeduimModeTotalGamesEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            meduimModeTotalGames: state.model.mediumModeTotalGames + 1,
          ),
        ),
      );
    });

    on<MeduimModeWinsEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            mediumModeWins: state.model.mediumModeWins + 1,
          ),
        ),
      );
    });

    on<HardModeTotalGamesEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            hardModeTotalGames: state.model.hardModeTotalGames + 1,
          ),
        ),
      );
    });

    on<HardModeWinsEvent>((event, emit) {
      emit(
        StatisticsUpdate(
          model: state.model.copyWith(
            hardModeWins: state.model.hardModeWins + 1,
          ),
        ),
      );
    });

    on<RecentGamesEvent>((event, emit) {
      final newGame = RecentGamesModel(
        modeName: event.modeName,
        gameResult: event.gameResult,
        gameDate: event.gameDate,
        gameResultColor: event.gameResultColor,
      );

      final List<RecentGamesModel> updatedRecentGamesList = List.from(
        state.model.recentGames,
      );

      updatedRecentGamesList.insert(0, newGame);

      emit(
        StatisticsUpdate(
          model: state.model.copyWith(recentGames: updatedRecentGamesList),
        ),
      );
    });
  }

  @override
  StatisticsState? fromJson(Map<String, dynamic> json) {
    try {
      final model = StatisticsModel.fromMap(
        json['statisticsModelState'] as Map<String, dynamic>,
      );
      return StatisticsUpdate(model: model);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(StatisticsState state) {
    return {'statisticsModelState': state.model.toMap()};
  }
}
