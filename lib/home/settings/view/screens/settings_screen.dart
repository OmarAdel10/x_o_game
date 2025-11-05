import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/link.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/settings/viewModel/settings_events.dart';
import 'package:x_o_game/home/settings/viewModel/settings_states.dart';
import 'package:x_o_game/home/settings/viewModel/settings_view_model.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final linkedInUri = Uri.parse('https://www.linkedin.com/in/omaradel10');
  final emailUri = Uri(scheme: 'mailto', path: 'omaradel1.dev@gmail.com');

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocListener<SettingsBloc, SettingsState>(
            listener: (context, state) {
              if (state is SettingsError) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(message: state.message),
                  animationDuration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  dismissType: DismissType.onSwipe,
                  dismissDirection: [
                    DismissDirection.horizontal,
                    DismissDirection.vertical,
                  ],
                  displayDuration: Duration(seconds: 1),
                  snackBarPosition: SnackBarPosition.top,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: Icon(
                        context.read<SettingsBloc>().state.model.language ==
                                'en'
                            ? CupertinoIcons.arrow_left
                            : CupertinoIcons.arrow_right,
                        size: 24,
                        color: Apptheme.silver,
                      ),
                    ),
                    const SizedBox(width: 20),
                    AutoSizeText(
                      localization.settings,
                      style: GoogleFonts.roboto(
                        color: Apptheme.silver,
                        fontSize: FontSizeManager.header,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Audio Card
                Card(
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Apptheme.semiDarkNavy,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Apptheme.shadowDark,
                          offset: const Offset(0, 8),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            localization.audio,
                            style: GoogleFonts.roboto(
                              color: Apptheme.silver,
                              fontSize: FontSizeManager.sectionTitle,
                              fontWeight: FontWeightManager.sectionTitles,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<SettingsBloc, SettingsState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        state.model.music
                                            ? CupertinoIcons.speaker_2
                                            : CupertinoIcons.speaker_slash,
                                        color: Apptheme.silver,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 16),
                                      AutoSizeText(
                                        localization.music,
                                        style: GoogleFonts.roboto(
                                          color: Apptheme.silver,
                                          fontSize: FontSizeManager.bodySmall,
                                          fontWeight: FontWeightManager.regular,
                                        ),
                                      ),
                                      Spacer(),

                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                          value: state.model.music,
                                          onChanged: (value) {
                                            context.read<SettingsBloc>().add(
                                              MusicToggle(),
                                            );
                                          },
                                          activeTrackColor: Apptheme.lightBlue,
                                          inactiveTrackColor: Apptheme.silver,
                                        ),
                                      ),
                                    ],
                                  ),

                                  ClipRRect(
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                      height: state.model.music ? 75 : 0,
                                      child: SingleChildScrollView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: AutoSizeText(
                                                localization.volume_percentage,
                                                maxLines: 1,
                                                minFontSize:
                                                    FontSizeManager.caption,
                                                style: GoogleFonts.roboto(
                                                  color: Apptheme.silver,
                                                  fontSize:
                                                      FontSizeManager.bodySmall,
                                                  fontWeight: FontWeightManager
                                                      .extraBold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: BlocBuilder<SettingsBloc, SettingsState>(
                                                    builder: (context, state) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                SettingsBloc
                                                              >()
                                                              .add(Volume25());
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                state
                                                                        .model
                                                                        .volume ==
                                                                    0.25
                                                                ? Apptheme
                                                                      .silver
                                                                : Apptheme
                                                                      .deepDarkNavy,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        0.25
                                                                    ? Apptheme
                                                                          .lightSilver
                                                                    : Apptheme
                                                                          .shadowDark,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      2,
                                                                    ),
                                                                blurRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: AutoSizeText(
                                                              localization.v25,
                                                              maxLines: 1,
                                                              minFontSize:
                                                                  FontSizeManager
                                                                      .caption,
                                                              style: GoogleFonts.roboto(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        0.25
                                                                    ? Apptheme
                                                                          .primary
                                                                    : Apptheme
                                                                          .silver,
                                                                fontSize:
                                                                    FontSizeManager
                                                                        .bodySmall,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .semiBold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: BlocBuilder<SettingsBloc, SettingsState>(
                                                    builder: (context, state) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                SettingsBloc
                                                              >()
                                                              .add(Volume50());
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                state
                                                                        .model
                                                                        .volume ==
                                                                    0.5
                                                                ? Apptheme
                                                                      .silver
                                                                : Apptheme
                                                                      .deepDarkNavy,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        0.5
                                                                    ? Apptheme
                                                                          .lightSilver
                                                                    : Apptheme
                                                                          .shadowDark,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      2,
                                                                    ),
                                                                blurRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: AutoSizeText(
                                                              localization.v50,
                                                              maxLines: 1,
                                                              minFontSize:
                                                                  FontSizeManager
                                                                      .caption,
                                                              style: GoogleFonts.roboto(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        0.5
                                                                    ? Apptheme
                                                                          .primary
                                                                    : Apptheme
                                                                          .silver,
                                                                fontSize:
                                                                    FontSizeManager
                                                                        .bodySmall,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .semiBold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: BlocBuilder<SettingsBloc, SettingsState>(
                                                    builder: (context, state) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                SettingsBloc
                                                              >()
                                                              .add(Volume75());
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                state
                                                                        .model
                                                                        .volume ==
                                                                    0.75
                                                                ? Apptheme
                                                                      .silver
                                                                : Apptheme
                                                                      .deepDarkNavy,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        0.75
                                                                    ? Apptheme
                                                                          .lightSilver
                                                                    : Apptheme
                                                                          .shadowDark,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      2,
                                                                    ),
                                                                blurRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: AutoSizeText(
                                                              localization.v75,
                                                              maxLines: 1,
                                                              minFontSize:
                                                                  FontSizeManager
                                                                      .caption,
                                                              style: GoogleFonts.roboto(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        0.75
                                                                    ? Apptheme
                                                                          .primary
                                                                    : Apptheme
                                                                          .silver,
                                                                fontSize:
                                                                    FontSizeManager
                                                                        .bodySmall,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .semiBold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: BlocBuilder<SettingsBloc, SettingsState>(
                                                    builder: (context, state) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                SettingsBloc
                                                              >()
                                                              .add(Volume100());
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                state
                                                                        .model
                                                                        .volume ==
                                                                    1.0
                                                                ? Apptheme
                                                                      .silver
                                                                : Apptheme
                                                                      .deepDarkNavy,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        1.0
                                                                    ? Apptheme
                                                                          .lightSilver
                                                                    : Apptheme
                                                                          .shadowDark,
                                                                offset:
                                                                    const Offset(
                                                                      0,
                                                                      2,
                                                                    ),
                                                                blurRadius: 1,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: AutoSizeText(
                                                              localization.v100,
                                                              maxLines: 1,
                                                              minFontSize:
                                                                  FontSizeManager
                                                                      .caption,
                                                              style: GoogleFonts.roboto(
                                                                color:
                                                                    state
                                                                            .model
                                                                            .volume ==
                                                                        1.0
                                                                    ? Apptheme
                                                                          .primary
                                                                    : Apptheme
                                                                          .silver,
                                                                fontSize:
                                                                    FontSizeManager
                                                                        .bodySmall,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .semiBold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Row(
                            children: [
                              BlocBuilder<SettingsBloc, SettingsState>(
                                builder: (context, state) {
                                  return Icon(
                                    state.model.soundEffects
                                        ? CupertinoIcons.speaker_2
                                        : CupertinoIcons.speaker_slash,
                                    color: Apptheme.silver,
                                    size: 24,
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              AutoSizeText(
                                localization.sound_effects,
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.bodySmall,
                                  fontWeight: FontWeightManager.regular,
                                ),
                              ),
                              Spacer(),

                              BlocBuilder<SettingsBloc, SettingsState>(
                                builder: (context, state) {
                                  return Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      value: state.model.soundEffects,
                                      onChanged: (value) {
                                        context.read<SettingsBloc>().add(
                                          SoundEffectsToggle(),
                                        );
                                      },
                                      activeTrackColor: Apptheme.lightBlue,
                                      inactiveTrackColor: Apptheme.silver,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Language Card
                Card(
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Apptheme.semiDarkNavy,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Apptheme.shadowDark,
                          offset: const Offset(0, 8),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            localization.language,
                            style: GoogleFonts.roboto(
                              color: Apptheme.silver,
                              fontSize: FontSizeManager.sectionTitle,
                              fontWeight: FontWeightManager.sectionTitles,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<SettingsBloc, SettingsState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<SettingsBloc>().add(
                                          LanguageUpdate('en'),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: state.model.language == 'en'
                                              ? Apptheme.silver
                                              : Apptheme.deepDarkNavy,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            localization.english,
                                            style: GoogleFonts.roboto(
                                              color:
                                                  state.model.language == 'en'
                                                  ? Apptheme.deepDarkNavy
                                                  : Apptheme.silver,
                                              fontSize:
                                                  FontSizeManager.bodyMedium,
                                              fontWeight:
                                                  FontWeightManager.semiBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.read<SettingsBloc>().add(
                                          LanguageUpdate('ar'),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: state.model.language == 'en'
                                              ? Apptheme.deepDarkNavy
                                              : Apptheme.silver,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            localization.arabic,
                                            style: GoogleFonts.roboto(
                                              color:
                                                  state.model.language == 'en'
                                                  ? Apptheme.silver
                                                  : Apptheme.deepDarkNavy,
                                              fontSize:
                                                  FontSizeManager.bodyMedium,
                                              fontWeight:
                                                  FontWeightManager.semiBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Language Card
                Card(
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Apptheme.semiDarkNavy,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: Apptheme.shadowDark,
                          offset: const Offset(0, 8),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            localization.about,
                            style: GoogleFonts.roboto(
                              color: Apptheme.silver,
                              fontSize: FontSizeManager.sectionTitle,
                              fontWeight: FontWeightManager.sectionTitles,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                localization.version,
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.bodySmall,
                                  fontWeight: FontWeightManager.regular,
                                ),
                              ),
                              Spacer(),
                              AutoSizeText(
                                '1.0.0',
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.bodySmall,
                                  fontWeight: FontWeightManager.extraBold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                localization.contact_developer_via,
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.bodySmall,
                                  fontWeight: FontWeightManager.regular,
                                ),
                              ),
                              Spacer(),
                              Link(
                                uri: linkedInUri,
                                target: LinkTarget.defaultTarget,
                                builder: (_, openLink) => GestureDetector(
                                  onTap: openLink,
                                  child: Image.asset(
                                    AssetsManager.linkedIn,
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Link(
                                uri: emailUri,
                                target: LinkTarget.defaultTarget,
                                builder: (_, openLink) => GestureDetector(
                                  onTap: openLink,
                                  child: Image.asset(
                                    AssetsManager.gamil,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
