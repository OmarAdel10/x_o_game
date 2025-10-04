import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _musicSwitchValue = true;
  bool _soundEffectsSwitchValue = true;
  bool _themeValue = true;

  bool isEnglishSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      size: 24,
                      color: Apptheme.silver,
                    ),
                  ),
                  const SizedBox(width: 20),
                  AutoSizeText(
                    'Settings',
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
                          'Audio',
                          style: GoogleFonts.roboto(
                            color: Apptheme.silver,
                            fontSize: FontSizeManager.sectionTitle,
                            fontWeight: FontWeightManager.sectionTitles,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              _musicSwitchValue
                                  ? CupertinoIcons.speaker_2
                                  : CupertinoIcons.speaker_slash,
                              color: Apptheme.silver,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            AutoSizeText(
                              'Music',
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
                                value: _musicSwitchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _musicSwitchValue = value;
                                  });
                                },
                                activeTrackColor: Apptheme.lightBlue,
                                inactiveTrackColor: Apptheme.silver,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              _soundEffectsSwitchValue
                                  ? CupertinoIcons.speaker_2
                                  : CupertinoIcons.speaker_slash,
                              color: Apptheme.silver,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            AutoSizeText(
                              'Sound Effects',
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
                                value: _soundEffectsSwitchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _soundEffectsSwitchValue = value;
                                  });
                                },
                                activeTrackColor: Apptheme.lightBlue,
                                inactiveTrackColor: Apptheme.silver,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
              // Display Card
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
                          'Display',
                          style: GoogleFonts.roboto(
                            color: Apptheme.silver,
                            fontSize: FontSizeManager.sectionTitle,
                            fontWeight: FontWeightManager.sectionTitles,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.moon,
                              color: Apptheme.silver,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            AutoSizeText(
                              'Theme',
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
                                value: _themeValue,
                                onChanged: (value) {
                                  setState(() {
                                    _themeValue = value;
                                  });
                                },
                                activeTrackColor: Apptheme.lightBlue,
                                inactiveTrackColor: Apptheme.silver,
                              ),
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
                          'Language',
                          style: GoogleFonts.roboto(
                            color: Apptheme.silver,
                            fontSize: FontSizeManager.sectionTitle,
                            fontWeight: FontWeightManager.sectionTitles,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  isEnglishSelected = true;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isEnglishSelected
                                        ? Apptheme.silver
                                        : Apptheme.deepDarkNavy,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'English',
                                      style: GoogleFonts.roboto(
                                        color: isEnglishSelected
                                            ? Apptheme.deepDarkNavy
                                            : Apptheme.silver,
                                        fontSize: FontSizeManager.bodyMedium,
                                        fontWeight: FontWeightManager.semiBold,
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
                                  isEnglishSelected = false;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isEnglishSelected
                                        ? Apptheme.deepDarkNavy
                                        : Apptheme.silver,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'العربية',
                                      style: GoogleFonts.roboto(
                                        color: isEnglishSelected
                                            ? Apptheme.silver
                                            : Apptheme.deepDarkNavy,
                                        fontSize: FontSizeManager.bodyMedium,
                                        fontWeight: FontWeightManager.semiBold,
                                      ),
                                    ),
                                  ),
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
    );
  }
}
