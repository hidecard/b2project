import '../models/cart_item.dart';
import '../models/customer.dart';
import '../models/order.dart';
import '../models/product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;
  static const String tableProducts = 'products';
  static const String tableCustomers = 'customers';
  static const String tableOrders = 'orders';
  static const String dbName = 'pos.db';
}