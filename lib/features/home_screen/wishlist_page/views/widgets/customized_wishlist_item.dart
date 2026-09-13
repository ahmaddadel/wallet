import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/l10n/app_translations.dart';

class CustomizedWishlistItem extends StatelessWidget {
  final String name;
  final double saved;
  final double price;

  const CustomizedWishlistItem({
    super.key,
    required this.name,
    required this.saved,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final tr =LocalizationService.instance.tr(context);
    final double ratio = price > 0 ? (saved / price).clamp(0.0, 1.0) : 0.0;
    final double value = ratio * 100;
    Color indicatorColor;
    if (value >= 90) {
      indicatorColor = AppColors.green;
    } else if (value >= 80) {
      indicatorColor = AppColors.violetBlue;
    } else if (value >= 50) {
      indicatorColor = AppColors.orange;
    } else {
      indicatorColor = AppColors.red;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
      width: double.infinity,
      height: AppHeight.h100,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppHeight.h50,
            height: AppWidth.w50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: AppSize.s4,
                  color: indicatorColor,
                ),
                Text(
                  '${value.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                    color: indicatorColor
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppWidth.w20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                SizedBox(height: AppHeight.h8),
                Text(
                  "${tr.saved}: $saved",
                  style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s14,
                  ),
                ),
                Text(
                  "\$$price",
                  style: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.regular,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
