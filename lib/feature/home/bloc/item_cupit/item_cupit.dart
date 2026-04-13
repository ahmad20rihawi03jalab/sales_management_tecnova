import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Data/database/db_helper.dart';
import '../../../../Data/models/item_model.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  ItemCubit() : super(ItemInitial());

  // 1. جلب كافة العناصر
  Future<void> getItems() async {
    emit(ItemLoading());
    try {
      final items = await dbHelper.getItems();
      emit(ItemGetSuccess(items));
    } catch (e) {
      emit(ItemError("فشل في جلب البيانات: ${e.toString()}"));
    }
  }

  // 2. إضافة عنصر جديد
  Future<void> addItem(ItemModel item) async {
    try {
      await dbHelper.createItem(item);
      emit(ItemAddSuccess());
      getItems();
    } catch (e) {
      print(
        "DATABASE ERROR: $e",
      ); // هذا السطر سيخبرك بالسبب الحقيقي في الـ Console
      emit(ItemError("فشل في إضافة العنصر: $e"));
    }
  }

  // 3. تعديل عنصر
  Future<void> updateItem(ItemModel item) async {
    try {
      await dbHelper.updateItem(item);
      emit(ItemUpdateSuccess());
      getItems(); // تحديث القائمة
    } catch (e) {
      emit(ItemError("فشل في تعديل العنصر"));
    }
  }

  // 4. حذف عنصر
  Future<void> deleteItem(int id) async {
    try {
      await dbHelper.deleteItem(id);
      emit(ItemDeleteSuccess());
      getItems(); // تحديث القائمة
    } catch (e) {
      emit(ItemError("فشل في حذف العنصر"));
    }
  }
}
