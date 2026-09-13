import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/core/app_router/app_router_keys.dart';
import 'package:wallet/core/customized_widgets/customized_button.dart';
import 'package:wallet/core/customized_widgets/customized_slidable.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/core/resources/app_fonts.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/features/home_screen/wishlist_page/cubit/wishlist_cubit.dart';
import 'package:wallet/features/home_screen/wishlist_page/cubit/wishlist_state.dart';
import 'package:wallet/features/home_screen/wishlist_page/views/widgets/customized_wishlist_item.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../../../../core/di/injector.dart';
import 'widgets/customized_money_text.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (_) => sl<WishlistCubit>()..getData(),
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          final cubit = WishlistCubit.get(context);
          final wishlist = cubit.wishlistItems;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                tr.wishlist,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
            backgroundColor: AppColors.wishListBackground,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: AppHeight.h280,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(AppSize.s14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomizedMoneyText(text: tr.availableMoney, money: cubit.availableMoney,),
                                CustomizedMoneyText(text: tr.wishlistTotal, money: cubit.totalWishlistMoney,),
                                CustomizedMoneyText(
                                  text: tr.amountNeeded,
                                  money: cubit.neededMoney,
                                  color: AppColors.violetBlue,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppHeight.h14),
                          Text(
                            tr.myGoals,
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s22,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: AppHeight.h10),
                          ListView.separated(
                            itemCount: wishlist.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              vertical: AppHeight.h10,
                            ),
                            itemBuilder: (context, index) {
                              final item = wishlist[index];
                              return CustomizedSlidAble(
                                child: CustomizedWishlistItem(
                                  name: item.name,
                                  price: item.targetPrice,
                                  saved: item.savingsAmount ?? 0,
                                ),
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return SizedBox(height: AppHeight.h10);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppHeight.h10),
                  CustomizedButton(
                    text: tr.addNewWish,
                    color: AppColors.violetBlue,
                    height: AppHeight.h45,
                    onTap: () async {
                      await context.push(AppRouterKeys.addNewWishlistScreen);
                      cubit.getData();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
