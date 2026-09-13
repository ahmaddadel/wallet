import 'package:wallet/domain/repos/wishlist_repository.dart';

class GetTotalWishlistUseCase {
  final WishlistRepository repo;

  GetTotalWishlistUseCase({required this.repo});

  Future<double> call() => repo.getTotalWishlist();
}
