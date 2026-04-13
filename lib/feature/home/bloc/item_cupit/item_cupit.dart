import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/database/db_helper.dart';
import '../../../../Data/models/item_model.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  ItemCubit() : super(ItemInitial());

  Future<void> getItems() async {
    emit(ItemLoading());
    try {
      final items = await dbHelper.getItems();
      emit(ItemGetSuccess(items));
    } catch (e) {
      emit(ItemError("فشل في جلب البيانات: ${e.toString()}"));
    }
  }

  Future<void> addItem(ItemModel item) async {
    try {
      await dbHelper.createItem(item);
      emit(ItemAddSuccess());
      getItems();
    } catch (e) {
      emit(ItemError("فشل في إضافة العنصر: $e"));
    }
  }

  Future<void> updateItem(ItemModel item) async {
    try {
      await dbHelper.updateItem(item);
      emit(ItemUpdateSuccess());
      getItems();
    } catch (e) {
      emit(ItemError("فشل في تعديل العنصر"));
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await dbHelper.deleteItem(id);
      emit(ItemDeleteSuccess());
      getItems();
    } catch (e) {
      emit(ItemError("فشل في حذف العنصر"));
    }
  }
}
