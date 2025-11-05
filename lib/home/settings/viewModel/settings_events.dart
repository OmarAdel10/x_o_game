sealed class SettingsEvent {}

class MusicToggle extends SettingsEvent {}

class Volume25 extends SettingsEvent {}

class Volume50 extends SettingsEvent {}

class Volume75 extends SettingsEvent {}

class Volume100 extends SettingsEvent {}

class SoundEffectsToggle extends SettingsEvent {}

class ClickSound extends SettingsEvent {}

class SuccessSound extends SettingsEvent {}

class LoseSound extends SettingsEvent {}

class LanguageUpdate extends SettingsEvent {
  final String language;

  LanguageUpdate(this.language);
}