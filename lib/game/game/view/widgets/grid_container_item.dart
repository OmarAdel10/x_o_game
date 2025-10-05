import 'package:flutter/material.dart';
import 'package:x_o_game/shared/apptheme.dart';

class GridContainerItem extends StatelessWidget {
  const GridContainerItem({super.key, required this.symbol});

  final String symbol;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Image.asset(
          'assets/images/${symbol.toUpperCase()}.png',
          width: 70,
          height: 70,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
