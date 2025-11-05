import 'package:flutter/material.dart';
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
      child: Container(
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
                ),
        ),
      ),
    );
  }
}
