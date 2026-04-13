import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item_model.dart'; // تأكد أن الموديل يحتوي على toMap و fromMap

class DatabaseHelper {
  // نمط السنجلتون (Singleton Pattern)
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  final String itemTable = 'item';

  // بواب الوصول لقاعدة البيانات
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // إعداد وفتح قاعدة البيانات
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'db_Ahmad.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // إنشاء الجدول عند أول تشغيل
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $itemTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT,
        quantity Double,
        unity TEXT
      )
    ''');
  }

  // التعامل مع تحديثات الإصدارات
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("DROP TABLE IF EXISTS $itemTable");
      await _onCreate(db, newVersion);
    }
  }

  // --- عمليات CRUD باستخدام الموديل ---

  // 1. إضافة عنصر جديد
  Future<int> createItem(ItemModel itemModel) async {
    final db = await database;
    return await db.insert(
      itemTable,
      itemModel.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // يستبدل العنصر إذا تكرر الـ ID
    );
  }

  // 2. جلب كافة العناصر وتحويلها لقائمة من الموديلات
  Future<List<ItemModel>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(itemTable);

    // تحويل كل Map من قاعدة البيانات إلى كائن ItemModel
    return List.generate(maps.length, (i) {
      return ItemModel.fromMap(maps[i]);
    });
  }

  // 3. حذف عنصر بواسطة المعرف (ID)
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(itemTable, where: 'id = ?', whereArgs: [id]);
  }

  // تابع تعديل عنصر موجود مسبقاً
  Future<int> updateItem(ItemModel itemModel) async {
    final db = await database; // الحصول على نسخة قاعدة البيانات

    return await db.update(
      itemTable, // اسم الجدول
      itemModel.toMap(), // البيانات الجديدة محولة إلى Map
      where: 'id = ?', // شرط التعديل (البحث عن العنصر بواسطة الـ id)
      whereArgs: [itemModel.id], // قيمة الـ id المستهدف
    );
  }
}
