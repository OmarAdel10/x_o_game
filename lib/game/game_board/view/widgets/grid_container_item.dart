import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:x_o_game/shared/apptheme.dart';

class GridContainerItem extends StatelessWidget {
  final String symbol;
  final int index;
  final VoidCallback onPressed;

  const GridContainerItem({
    super.key,
    required this.symbol,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child:
          Container(
                decoration: BoxDecoration(
                  color: Apptheme.semiDarkNavy,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Apptheme.shadowDark,
                      offset: const Offset(0, 8),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: symbol.isEmpty
                      ? null
                      : Image.asset(
                              'assets/images/${symbol.toUpperCase()}.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.fill,
                            )
                            .animate()
                            .scale(
                              begin: Offset(0, 0),
                              end: Offset(1.1, 1.1),
                              alignment: Alignment.center,
                              curve: Curves.easeOut,
                              duration: Duration(milliseconds: 150),
                            )
                            .then()
                            .scale(
                              begin: Offset(1.1, 1.1),
                              end: Offset(1, 1),
                              alignment: Alignment.center,
                              curve: Curves.easeIn,
                              duration: Duration(milliseconds: 150),
                            )
                            .animate(
                              onPlay: (controller) => controller.forward(),
                            )
                            .rotate(
                              begin: -90 / 360,
                              alignment: Alignment.center,
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 200),
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
              .scale(
                alignment: Alignment.center,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 600),
                begin: Offset(0, 0),
              ),
    );
  }
}
