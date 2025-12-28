import '../models/cart_item.dart';
import '../models/customer.dart';
import '../models/order.dart';
import '../models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static const String tableProducts = 'products';
  static const String tableCustomers = 'customers';
  static const String tableOrders = 'orders';
  static const String dbName = 'pos.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future<void> _onCreate(Database db, int version) async{
            await db.execute('''
                  CREATE TABLE $tableProducts(
                  id INTEGER PRIMARY KEY,
                  name TEXT,
                  price REAL,
                  imageUrl TEXT,
                  stock INTEGER
                  )
                  ''');
            await db.execute('''
                CREATE TABLE $tableCustomers(
                id INTEGER PRIMARY KEY,
                name TEXT,
                phone TEXT,
                email TEXT
                )
                ''');
            await db.execute('''
                CREATE TABLE $tableOrders(
                id INTEGER PRIMARY KEY,
                customerId INTEGER,
                items TEXT,
                total REAL,
                date TEXT
                )
                ''');
    await db.insert(tableProducts, {
      'id': 1,
      'name': 'Coffee',
      'price': 6000,
      'imageUrl': '',
      'stock': 10,
    });
    await db.insert(tableProducts, {
      'id': 2,
      'name': 'Cake',
      'price': 4500,
      'imageUrl': '',
      'stock': 20,
    });
    await db.insert(tableCustomers, {
      'id': 1,
      'name': 'Arkar',
      'phone': '09758340371',
      'email': 'arkaryan.info@gmail.com',
    });
  }
}