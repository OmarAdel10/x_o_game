import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:x_o_game/home/settings/data/models/settings_model.dart';
import 'package:x_o_game/home/settings/viewModel/settings_events.dart';
import 'package:x_o_game/home/settings/viewModel/settings_states.dart';
import 'package:just_audio/just_audio.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  final musicPlayer = AudioPlayer();
  final clickPlayer = AudioPlayer();
  final successPlayer = AudioPlayer();
  final losePlayer = AudioPlayer();

  SettingsBloc()
    : super(
        SettingsInitial(
          model: SettingsModel(
            music: true,
            soundEffects: true,
            language: 'en',
            volume: 1.0,
          ),
        ),
      ) {
    _initialize();

    on<MusicToggle>((event, emit) async {
      await musicPlayer.setVolume(state.model.volume);
      final newMusicState = !state.model.music;
      emit(
        SettingsUpdate(
          model: state.model.copyWith(
            music: !state.model.music,
            volume: state.model.volume,
          ),
        ),
      );
      if (newMusicState) {
        try {
          await musicPlayer.setLoopMode(LoopMode.all);
          await musicPlayer.play();
        } catch (e) {
          log('Error playing music: $e');
          emit(SettingsError('Failed to play music', model: state.model));
        }
      } else {
        await musicPlayer.stop();
      }
    });

    on<Volume25>((event, emit) async {
      musicPlayer.setVolume(0.25);
      emit(SettingsUpdate(model: state.model.copyWith(volume: 0.25)));
    });

    on<Volume50>((event, emit) {
      musicPlayer.setVolume(0.5);
      emit(SettingsUpdate(model: state.model.copyWith(volume: 0.5)));
    });

    on<Volume75>((event, emit) {
      musicPlayer.setVolume(0.75);
      emit(SettingsUpdate(model: state.model.copyWith(volume: 0.75)));
    });

    on<Volume100>((event, emit) {
      musicPlayer.setVolume(1);
      emit(SettingsUpdate(model: state.model.copyWith(volume: 1)));
    });

    on<SoundEffectsToggle>((event, emit) {
      emit(
        SettingsUpdate(
          model: state.model.copyWith(soundEffects: !state.model.soundEffects),
        ),
      );
    });

    on<ClickSound>((event, emit) async {
      if (state.model.soundEffects) {
        try {
          await clickPlayer.seek(Duration.zero);
          await clickPlayer.play();
        } catch (e) {
          log('Error playing click sound: $e');
        }
      }
    });

    on<SuccessSound>((event, emit) async {
      if (state.model.soundEffects) {
        try {
          await successPlayer.seek(Duration.zero);
          successPlayer.play();
        } catch (e) {
          log('Error playing success sound: $e');
        }
      }
    });

    on<LoseSound>((event, emit) async {
      if (state.model.soundEffects) {
        try {
          await losePlayer.seek(Duration.zero);
          losePlayer.play();
        } catch (e) {
          log('Error playing lose sound: $e');
        }
      }
    });

    on<LanguageUpdate>((event, emit) {
      emit(
        SettingsUpdate(model: state.model.copyWith(language: event.language)),
      );
    });
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      final model = SettingsModel.fromMap(
        json["settingsState"] as Map<String, dynamic>,
      );
      return SettingsUpdate(model: model);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {"settingsState": state.model.toMap()};
  }

  Future<void> _initialize() async {
    await _preloadAudio();
    await _initializeAudioState();
  }

  Future<void> _preloadAudio() async {
    try {
      await musicPlayer.setAudioSource(
        AudioSource.asset('assets/sounds/Rubiks-Dodecahedron.mp3'),
        initialPosition: Duration.zero,
        preload: true,
      );
      await clickPlayer.setAudioSource(
        AudioSource.asset('assets/sounds/click.mp3'),
        initialPosition: Duration.zero,
        preload: true,
      );
      await successPlayer.setAudioSource(
        AudioSource.asset('assets/sounds/success.mp3'),
        initialPosition: Duration.zero,
        preload: true,
      );
      await losePlayer.setAudioSource(
        AudioSource.asset('assets/sounds/lose.mp3'),
        initialPosition: Duration.zero,
        preload: true,
      );
    } catch (e) {
      log('Error preloading audio: $e');
    }
  }

  Future<void> _initializeAudioState() async {
    try {
      if (state.model.music) {
        musicPlayer.setVolume(state.model.volume);
        await musicPlayer.setLoopMode(LoopMode.all);
        await musicPlayer.play();
      }
    } catch (e) {
      log('Error initializing audio state: $e');
    }
  }

  @override
  Future<void> close() async {
    try {
      await musicPlayer.stop();
      await musicPlayer.dispose();
      await clickPlayer.stop();
      await clickPlayer.dispose();
      await successPlayer.stop();
      await successPlayer.dispose();
      await losePlayer.stop();
      await losePlayer.dispose();
    } catch (e) {
      log('Error disposing audio player: $e');
    }
    return super.close();
  }
}
