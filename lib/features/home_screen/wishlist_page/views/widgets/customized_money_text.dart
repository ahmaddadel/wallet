import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_fonts.dart';

class CustomizedMoneyText extends StatelessWidget {
  final String text;
  final double money;
  final Color color;

  const CustomizedMoneyText({
    super.key,
    this.color = AppColors.black,
    required this.text,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
            ),
          ),
          Text(
            "$money",
            style: TextStyle(
              color: color,
              fontWeight: FontWeightManager.bold,
              fontSize: FontSize.s32,
            ),
          ),
        ],
      ),
    );
  }
}
