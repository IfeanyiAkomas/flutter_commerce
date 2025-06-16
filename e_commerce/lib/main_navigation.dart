import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with TickerProviderStateMixin {
  int _currentIndex = 0;

  final List<Widget> _screens = [
  HomeScreen(),
  CartScreen(),
  ProfileScreen(),
];


  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.shopping_cart_rounded,
    Icons.person_rounded,
  ];

  final List<String> _titles = [
    "Home",
    "Cart",
    "Profile",
  ];

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        items: List.generate(_icons.length, (index) {
          final isSelected = _currentIndex == index;
          return BottomNavigationBarItem(
            icon: ScaleTransition(
              scale: isSelected ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
              child: Icon(_icons[index]),
            ),
            label: _titles[index],
          );
        }),
        onTap: _onTabTapped,
      ),
    );
  }
}
