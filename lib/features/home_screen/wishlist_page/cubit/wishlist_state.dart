abstract class WishlistState {}

class WishlistInitialState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistErrorState extends WishlistState {
  final String error ;
  WishlistErrorState({required this.error});
}

class WishlistSuccessState extends WishlistState {}
