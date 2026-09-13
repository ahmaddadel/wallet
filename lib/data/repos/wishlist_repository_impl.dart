import 'package:hive/hive.dart';
import 'package:wallet/data/models/wishlist/wishlist_model.dart';
import 'package:wallet/domain/entities/wishlist_entities.dart';
import 'package:wallet/domain/repos/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final Box<WishlistModel> box;

  WishlistRepositoryImpl({required this.box});

  @override
  Future<void> addWishlist(WishlistEntity wishlistItem) async {
    final model = WishlistModel.fromEntity(wishlistItem);
    await box.put(model.id, model);
  }

  @override
  Future<void> updateWishlist(WishlistEntity wishlistItem) async {
    final model = WishlistModel.fromEntity(wishlistItem);
    await box.put(model.id, model);
  }

  @override
  Future<void> deleteWishlist(int id) async {
    await box.delete(id);
  }

  @override
  Future<void> deleteAllWishlist() async {
    await box.clear();
  }

  @override
  Future<List<WishlistEntity>> getAllWishlist() async {
    final models = box.values.toList();
    return models.map((element) => element.toEntity()).toList();
  }

  @override
  Future<double> getAvailableMoney() async {
    final models = box.values.toList();
    return models.fold<double>(
      0.0,
      (total, item) => total + (item.savingsAmount ?? 0.0),
    );
  }

  @override
  Future<double> getTotalAmountNeeded() async {
    final models = box.values.toList();
    return models.fold<double>(
      0.0,
      (total, item) => total + (item.targetPrice - (item.savingsAmount ?? 0.0)),
    );
  }

  @override
  Future<double> getTotalWishlist() async {
    final models = box.values.toList();
    return models.fold<double>(0.0, (total, item) => total + item.targetPrice);
  }
}
