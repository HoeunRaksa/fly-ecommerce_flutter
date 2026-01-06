import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/profile/screen/profile_screen.dart';
import '../screen/home_screen.dart';

/// Glass iOS 26 Bottom Bar (logic unchanged)
class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBar();
}

class _HomeBottomBar extends State<HomeBottomBar> {
  int _currentIndex = 0;

  // Screens list — use YOUR own screens only
  final List<Widget> _screens = [
    const HomeScreen(), // Home
    const HomeScreen(), // Replace with your actual favorite screen if exists
    const HomeScreen(), // Replace with your actual shopping/cart screen if exists
    const ProfileScreen(), // Profile
  ];

  // iOS system colors
  final Color activeColor = CupertinoColors.systemOrange;
  final Color inactiveColor = CupertinoColors.systemGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          height: 70,
          backgroundColor: CupertinoColors.systemBackground,
          elevation: 0,
          indicatorColor: CupertinoColors.systemOrange.withOpacity(0.12),
          animationDuration: const Duration(milliseconds: 350),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.house,
                color: _currentIndex == 0 ? activeColor : inactiveColor,
              ),
              selectedIcon: Icon(
                CupertinoIcons.house_fill,
                color: activeColor,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.heart,
                color: _currentIndex == 1 ? activeColor : inactiveColor,
              ),
              selectedIcon: Icon(
                CupertinoIcons.heart_fill,
                color: activeColor,
              ),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: Badge(
                label: const Text('3'),
                backgroundColor: CupertinoColors.systemRed,
                child: Icon(
                  CupertinoIcons.cart,
                  color: _currentIndex == 2 ? activeColor : inactiveColor,
                ),
              ),
              selectedIcon: Badge(
                label: const Text('3'),
                backgroundColor: CupertinoColors.systemRed,
                child: Icon(
                  CupertinoIcons.cart_fill,
                  color: activeColor,
                ),
              ),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.person,
                color: _currentIndex == 3 ? activeColor : inactiveColor,
              ),
              selectedIcon: Icon(
                CupertinoIcons.person_fill,
                color: activeColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
