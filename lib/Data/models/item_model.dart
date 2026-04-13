class ItemModel {
  final int? id;
  final String name;
  final double quantity; // تأكد أنها double
  final String unity;

  ItemModel({
    this.id,
    required this.name,
    required this.quantity,
    required this.unity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_name':
          name, // تأكد أن المفاتيح تطابق أسماء الأعمدة في DatabaseHelper
      'quantity': quantity,
      'unity': unity,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['item_name'] ?? '',
      // تحويل آمن للرقم القادم من قاعدة البيانات
      quantity: (map['quantity'] as num?)?.toDouble() ?? 0.0,
      unity: map['unity'] ?? '',
    );
  }
}
