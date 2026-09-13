import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/domain/entities/wishlist_entities.dart';
import 'package:wallet/domain/use_cases/wishlist_use_cases/get_all_wishlists_use_cases.dart';
import 'package:wallet/domain/use_cases/wishlist_use_cases/get_available_money_use_case.dart';
import 'package:wallet/domain/use_cases/wishlist_use_cases/get_needed_money_use_case.dart';
import 'package:wallet/domain/use_cases/wishlist_use_cases/get_wishlist_total_use_case.dart';
import 'package:wallet/features/home_screen/wishlist_page/cubit/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetAllWishlistUseCase getAllWishlistUseCase;
  final GetTotalWishlistUseCase getTotalWishlistUseCase;
  final GetAvailableMoneyUseCase getAvailableMoneyUseCase;
  final GetNeededMoneyUseCase getNeededMoneyUseCase;

  WishlistCubit({
    required this.getAllWishlistUseCase,
    required this.getNeededMoneyUseCase,
    required this.getAvailableMoneyUseCase,
    required this.getTotalWishlistUseCase,
  }) : super(WishlistInitialState());

  static WishlistCubit get(context) => BlocProvider.of(context);

  double availableMoney = 0;
  double neededMoney = 0;
  double totalWishlistMoney = 0;
  List<WishlistEntity> wishlistItems = [];

  Future<void> getData() async {
    emit(WishlistLoadingState());
    try {
      wishlistItems = await getAllWishlistUseCase.call();
      availableMoney = await getAvailableMoneyUseCase.call();
      neededMoney = await getNeededMoneyUseCase.call();
      totalWishlistMoney = await getTotalWishlistUseCase.call();
      emit(WishlistSuccessState());
    } catch (e) {
      emit(WishlistErrorState(error: e.toString()));
    }
  }
}
