import 'package:equatable/equatable.dart';
import 'package:x_o_game/home/settings/data/models/settings_model.dart';

abstract class SettingsState extends Equatable {
  final SettingsModel model;

  const SettingsState({required this.model});

  @override
  List<Object?> get props => [model];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({required super.model});
}

class SettingsUpdate extends SettingsState {
  const SettingsUpdate({required super.model});
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message, {required super.model});

  @override
  List<Object?> get props => [model, message];
}
