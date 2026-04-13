import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  final String itemTable = 'item';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'db_Ahmad.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

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

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("DROP TABLE IF EXISTS $itemTable");
      await _onCreate(db, newVersion);
    }
  }

  Future<int> createItem(ItemModel itemModel) async {
    final db = await database;
    return await db.insert(
      itemTable,
      itemModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemModel>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(itemTable);

    return List.generate(maps.length, (i) {
      return ItemModel.fromMap(maps[i]);
    });
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete(itemTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateItem(ItemModel itemModel) async {
    final db = await database;

    return await db.update(
      itemTable,
      itemModel.toMap(),
      where: 'id = ?',
      whereArgs: [itemModel.id],
    );
  }
}
