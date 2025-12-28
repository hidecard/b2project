import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import './screens/backup_restore_screen.dart';
import './screens/cart_screen.dart';
import './screens/customer_screen.dart';
import './screens/home_screen.dart';
import './screens/order_history_screen.dart';
import './screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS System',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: MainScreen(),
      getPages: [
        GetPage(name: '/cart', page: () => CartScreen()),
        GetPage(name: '/product_management', page: () => ProductScreen()),
        GetPage(name: '/customer_management', page: () => CustomerScreen()),
        GetPage(name: '/order_history', page: () => OrderHistoryScreen()),
      ],
    );
  }
}

class MainScreen extends StatelessWidget {
  final RxInt _currentIndex = 0.obs;

  final List<Widget> _screens = [
    HomeScreen(),
    ProductScreen(),
    CustomerScreen(),
    OrderHistoryScreen(),
    BackupRestoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(index: _currentIndex.value, children: _screens),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _currentIndex.value,
          onTap: (index) => _currentIndex.value = index,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Customers',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.backup), label: 'Backup'),
          ],
        ),
      ),
      floatingActionButton: badges.Badge(
        badgeContent: Text('0', style: TextStyle(color: Colors.white)),
        child: FloatingActionButton(
          heroTag: 'cart_fab',
          onPressed: () => Get.toNamed('/cart'),
          child: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
