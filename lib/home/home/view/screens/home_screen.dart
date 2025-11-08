import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:x_o_game/game/pvb/view/screens/player_vs_bot_screen.dart';
import 'package:x_o_game/game/pvp/view/screens/player_vs_player_screen.dart';
import 'package:x_o_game/generated/l10n.dart';
import 'package:x_o_game/home/settings/view/screens/settings_screen.dart';
import 'package:x_o_game/home/statistics/view/screens/statistics_screen.dart';
import 'package:x_o_game/main.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/assets_manager.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';
import 'package:x_o_game/shared/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  Key _animationKey = UniqueKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    setState(() {
      _animationKey = UniqueKey();
    });
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            key: _animationKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                    AssetsManager.logo,
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                  )
                  .animate()
                  .scale(
                    delay: Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                  )
                  .fadeIn(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  ),
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
                          children: [
                            Center(
                              child: Text(
                                localization.pick_mode,
                                style: GoogleFonts.roboto(
                                  color: Apptheme.silver,
                                  fontSize: FontSizeManager.bodyMedium,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            CustomButton(
                              backgroundColor: Apptheme.lightBlue,
                              shadowColor: Apptheme.shadowBlue,
                              text: localization.new_game_player,
                              onPressed: () => context.pushNamedTransition(
                                routeName: PlayerVsPlayerScreen.routeName,
                                type: PageTransitionType.fade,
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 300),
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              backgroundColor: Apptheme.lightYellow,
                              shadowColor: Apptheme.shadowYellow,
                              text: localization.new_game_bot,
                              onPressed: () => context.pushNamedTransition(
                                routeName: PlayerVsBotScreen.routeName,
                                type: PageTransitionType.fade,
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 300),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(
                    begin: 0,
                    delay: Duration(milliseconds: 200),
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  )
                  .slideY(
                    begin: 0.1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => context.pushNamedTransition(
                      routeName: StatisticsScreen.routeName,
                      type: PageTransitionType.fade,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300),
                    ),

                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Apptheme.silver,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(CupertinoIcons.graph_circle, size: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () => context.pushNamedTransition(
                      routeName: SettingsScreen.routeName,
                      type: PageTransitionType.fade,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300),
                    ),

                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Apptheme.silver,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(CupertinoIcons.gear, size: 24),
                    ),
                  ),
                ],
              ).animate().fadeIn(
                delay: Duration(milliseconds: 200),
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
