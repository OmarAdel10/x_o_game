// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PICK MODE`
  String get pick_mode {
    return Intl.message('PICK MODE', name: 'pick_mode', desc: '', args: []);
  }

  /// `NEW GAME ( VS PLAYER )`
  String get new_game_player {
    return Intl.message(
      'NEW GAME ( VS PLAYER )',
      name: 'new_game_player',
      desc: '',
      args: [],
    );
  }

  /// `NEW GAME ( VS BOT )`
  String get new_game_bot {
    return Intl.message(
      'NEW GAME ( VS BOT )',
      name: 'new_game_bot',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Audio`
  String get audio {
    return Intl.message('Audio', name: 'audio', desc: '', args: []);
  }

  /// `Music`
  String get music {
    return Intl.message('Music', name: 'music', desc: '', args: []);
  }

  /// `Sound Effects`
  String get sound_effects {
    return Intl.message(
      'Sound Effects',
      name: 'sound_effects',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Contact Developer Via`
  String get contact_developer_via {
    return Intl.message(
      'Contact Developer Via',
      name: 'contact_developer_via',
      desc: '',
      args: [],
    );
  }

  /// `Game Statistics`
  String get game_statistics {
    return Intl.message(
      'Game Statistics',
      name: 'game_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Overall Stats`
  String get overall_stats {
    return Intl.message(
      'Overall Stats',
      name: 'overall_stats',
      desc: '',
      args: [],
    );
  }

  /// `Total Games`
  String get total_games {
    return Intl.message('Total Games', name: 'total_games', desc: '', args: []);
  }

  /// `Draws`
  String get draws {
    return Intl.message('Draws', name: 'draws', desc: '', args: []);
  }

  /// `PvP Games`
  String get pvp_games {
    return Intl.message('PvP Games', name: 'pvp_games', desc: '', args: []);
  }

  /// `vs Bot`
  String get vs_bot {
    return Intl.message('vs Bot', name: 'vs_bot', desc: '', args: []);
  }

  /// `Bot Challenge Stats`
  String get bot_challenge_stats {
    return Intl.message(
      'Bot Challenge Stats',
      name: 'bot_challenge_stats',
      desc: '',
      args: [],
    );
  }

  /// `Easy`
  String get easy {
    return Intl.message('Easy', name: 'easy', desc: '', args: []);
  }

  /// `Medium`
  String get medium {
    return Intl.message('Medium', name: 'medium', desc: '', args: []);
  }

  /// `Hard`
  String get hard {
    return Intl.message('Hard', name: 'hard', desc: '', args: []);
  }

  /// `Win Rate`
  String get win_rate {
    return Intl.message('Win Rate', name: 'win_rate', desc: '', args: []);
  }

  /// `Wins`
  String get wins {
    return Intl.message('Wins', name: 'wins', desc: '', args: []);
  }

  /// `Recent Games`
  String get recent_games {
    return Intl.message(
      'Recent Games',
      name: 'recent_games',
      desc: '',
      args: [],
    );
  }

  /// `No recent games to show.`
  String get no_recent_games {
    return Intl.message(
      'No recent games to show.',
      name: 'no_recent_games',
      desc: '',
      args: [],
    );
  }

  /// `Player Setup`
  String get player_setup {
    return Intl.message(
      'Player Setup',
      name: 'player_setup',
      desc: '',
      args: [],
    );
  }

  /// `Player 1 Name`
  String get player_one_name {
    return Intl.message(
      'Player 1 Name',
      name: 'player_one_name',
      desc: '',
      args: [],
    );
  }

  /// `Player 2 Name`
  String get player_two_name {
    return Intl.message(
      'Player 2 Name',
      name: 'player_two_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Name ( or playas as Guest )`
  String get enter_name {
    return Intl.message(
      'Enter Name ( or playas as Guest )',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Flip Coin & Start`
  String get flip_coin_and_start {
    return Intl.message(
      'Flip Coin & Start',
      name: 'flip_coin_and_start',
      desc: '',
      args: [],
    );
  }

  /// `Bot Challenge`
  String get bot_challenge {
    return Intl.message(
      'Bot Challenge',
      name: 'bot_challenge',
      desc: '',
      args: [],
    );
  }

  /// `I'll go easy on you!`
  String get Ill_go_easy_on_you {
    return Intl.message(
      'I\'ll go easy on you!',
      name: 'Ill_go_easy_on_you',
      desc: '',
      args: [],
    );
  }

  /// `This should be fun!`
  String get This_should_be_fun {
    return Intl.message(
      'This should be fun!',
      name: 'This_should_be_fun',
      desc: '',
      args: [],
    );
  }

  /// `You asked for it.... 😈`
  String get You_asked_for_it {
    return Intl.message(
      'You asked for it.... 😈',
      name: 'You_asked_for_it',
      desc: '',
      args: [],
    );
  }

  /// `Bot Difficulty`
  String get bot_difficulty {
    return Intl.message(
      'Bot Difficulty',
      name: 'bot_difficulty',
      desc: '',
      args: [],
    );
  }

  /// `Flipping Coin ..........`
  String get flipping_coin {
    return Intl.message(
      'Flipping Coin ..........',
      name: 'flipping_coin',
      desc: '',
      args: [],
    );
  }

  /// `Heads`
  String get heads {
    return Intl.message('Heads', name: 'heads', desc: '', args: []);
  }

  /// `Tails`
  String get tails {
    return Intl.message('Tails', name: 'tails', desc: '', args: []);
  }

  /// `Coin Flip!`
  String get coin_flip {
    return Intl.message('Coin Flip!', name: 'coin_flip', desc: '', args: []);
  }

  /// `uses`
  String get uses {
    return Intl.message('uses', name: 'uses', desc: '', args: []);
  }

  /// `if heads, otherwise`
  String get if_heads {
    return Intl.message(
      'if heads, otherwise',
      name: 'if_heads',
      desc: '',
      args: [],
    );
  }

  /// `TAKES THE ROUND`
  String get takes_the_round {
    return Intl.message(
      'TAKES THE ROUND',
      name: 'takes_the_round',
      desc: '',
      args: [],
    );
  }

  /// `WINS!`
  String get game_wins {
    return Intl.message('WINS!', name: 'game_wins', desc: '', args: []);
  }

  /// `QUIT`
  String get quit {
    return Intl.message('QUIT', name: 'quit', desc: '', args: []);
  }

  /// `NEXT ROUND`
  String get next_round {
    return Intl.message('NEXT ROUND', name: 'next_round', desc: '', args: []);
  }

  /// `ROUND TIED`
  String get round_tied {
    return Intl.message('ROUND TIED', name: 'round_tied', desc: '', args: []);
  }

  /// `TURN`
  String get turn {
    return Intl.message('TURN', name: 'turn', desc: '', args: []);
  }

  /// `25%`
  String get v25 {
    return Intl.message('25%', name: 'v25', desc: '', args: []);
  }

  /// `50%`
  String get v50 {
    return Intl.message('50%', name: 'v50', desc: '', args: []);
  }

  /// `75%`
  String get v75 {
    return Intl.message('75%', name: 'v75', desc: '', args: []);
  }

  /// `100%`
  String get v100 {
    return Intl.message('100%', name: 'v100', desc: '', args: []);
  }

  /// `Volume Percentage`
  String get volume_percentage {
    return Intl.message(
      'Volume Percentage',
      name: 'volume_percentage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
