import '../../../../Data/models/item_model.dart';

abstract class ItemState {}

// الحالة الابتدائية
class ItemInitial extends ItemState {}

// حالة التحميل (تظهر عند جلب البيانات أو تنفيذ عملية)
class ItemLoading extends ItemState {}

// حالة النجاح في جلب البيانات (تحتوي على قائمة العناصر)
class ItemGetSuccess extends ItemState {
  final List<ItemModel> items;
  ItemGetSuccess(this.items);
}

// حالة النجاح في الإضافة
class ItemAddSuccess extends ItemState {}

// حالة النجاح في التعديل
class ItemUpdateSuccess extends ItemState {}

// حالة النجاح في الحذف
class ItemDeleteSuccess extends ItemState {}

// حالة حدوث خطأ (تحتوي على رسالة الخطأ)
class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}
