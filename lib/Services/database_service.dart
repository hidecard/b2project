import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/customer.dart';

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

  // customer CRUD
Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableCustomers);
    return List.generate(maps.length, (i) => Customer.fromMap(maps[i]));
  }

  Future<void> addCustomer(Customer customer) async {
    final db = await database;
    await db.insert(
      tableCustomers,
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> updateCustomer(Customer customer) async {
    final db = await database;
    await db.update(
      tableCustomers,
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteCustomer(int id) async {
    final db = await database;
    await db.delete(tableCustomers, where: 'id = ?', whereArgs: [id]);
  }
}