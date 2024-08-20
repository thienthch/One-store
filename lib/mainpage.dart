import 'package:flutter/material.dart';
import 'package:one_store/page/favourite/favouritescreen.dart';
import 'package:one_store/page/home/homescreen.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:one_store/page/search/searchscreen.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    SearchScreen()
    // AccountWidget(), // Uncomment nếu bạn có trang này
  ];

  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home_filled, 'label': 'Home'},
    {'icon': Icons.favorite, 'label': 'Favorite'},
    {'icon': Icons.search, 'label': 'Search'},
    {'icon': Icons.shopping_bag, 'label': 'Cart'},
    {'icon': Icons.dehaze, 'label': 'Setting'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgetOptions,
      ),
      bottomNavigationBar: CircleNavBar(
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        height: 60,
        circleWidth: 60,
        activeIndex: _selectedIndex,
        circleColor: const Color(0xFFF3B664),
        color: const Color(0xFFEC8F5E),
        activeIcons: List.generate(
            navItems.length, (index) => Icon(navItems[index]['icon'])),
        inactiveIcons: List.generate(navItems.length,
            (index) => Icon(navItems[index]['icon'], color: Colors.white)),
      ),
    );
  }
}
