import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final bool music;
  final bool soundEffects;
  final String language;
  final double volume;

  const SettingsModel({
    required this.music,
    required this.soundEffects,
    required this.language,
    required this.volume
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'music': music,
      'soundEffects': soundEffects,
      'language': language,
      'volume' : volume
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      music: map['music'] as bool,
      soundEffects: map['soundEffects'] as bool,
      language: map['language'] as String,
      volume: (map['volume'] ?? 1.0) as double,
      
    );
  }

  @override
  List<Object?> get props => [music, soundEffects, language, volume];

  SettingsModel copyWith({
    bool? music,
    bool? soundEffects,
    String? language,
    double? volume,
  }) {
    return SettingsModel(
      music: music ?? this.music,
      soundEffects: soundEffects ?? this.soundEffects,
      language: language ?? this.language,
      volume: volume ?? this.volume, 
    );
  }
}
