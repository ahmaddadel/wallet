import 'package:wallet/domain/repos/wishlist_repository.dart';

class GetAvailableMoneyUseCase {
  final WishlistRepository repo;

  GetAvailableMoneyUseCase({required this.repo});

  Future<double> call() => repo.getAvailableMoney();
}
