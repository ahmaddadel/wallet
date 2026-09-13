import 'package:wallet/domain/entities/wishlist_entities.dart';
import 'package:wallet/domain/repos/wishlist_repository.dart';

class GetAllWishlistUseCase {
  final WishlistRepository repo;

  GetAllWishlistUseCase({required this.repo});

  Future<List<WishlistEntity>> call() => repo.getAllWishlist();
}