import '../../../../Data/models/item_model.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemGetSuccess extends ItemState {
  final List<ItemModel> items;
  ItemGetSuccess(this.items);
}

class ItemAddSuccess extends ItemState {}

class ItemUpdateSuccess extends ItemState {}

class ItemDeleteSuccess extends ItemState {}

class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}
