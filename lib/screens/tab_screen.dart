import 'package:blog_app/constants/colors_constants.dart';
import 'package:blog_app/screens/favorites_screen.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  static const routename = "/tabscreen";
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>>? _pages;
  int _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'page': const FavoritesScreen(),
        'title': 'My Favorites',
      },
      {
        'page': const HomePage(),
        'title': 'Home',
      },
      {
        'page': const ProfileScreen(),
        'title': 'My Profile',
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_pages?[_selectedPageIndex]['page'] as Widget),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.borderColor,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          iconSize: 24,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            )
          ]),
    );
  }
}
