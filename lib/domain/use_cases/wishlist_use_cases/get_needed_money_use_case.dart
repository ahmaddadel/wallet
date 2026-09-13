import 'package:wallet/domain/repos/wishlist_repository.dart';

class GetNeededMoneyUseCase{
   final WishlistRepository repo;
   GetNeededMoneyUseCase({required this.repo});

   Future<double> call() => repo.getTotalAmountNeeded();
}