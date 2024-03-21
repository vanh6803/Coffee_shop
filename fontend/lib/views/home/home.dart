import 'package:flutter/material.dart';
import 'package:fontend/constant/color.dart';
import 'package:fontend/views/home/cart/cart_screen.dart';
import 'package:fontend/views/home/product/product_screen.dart';
import 'package:fontend/views/home/profile/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final _tab = [ProductScreen(), CartScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tab[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
        unselectedLabelStyle: const TextStyle(fontSize: 0),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[500],
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 24),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
