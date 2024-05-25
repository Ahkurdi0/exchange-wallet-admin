import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.1),
          //   spreadRadius: 0,
          //   blurRadius: 0,
          //   offset: Offset(0, -1), // Shadow position
          // ),
        ],
      ),
      child: SalomonBottomBar(
        currentIndex: widget.selectedIndex,
        onTap: (index) => widget.onDestinationSelected(index),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        unselectedItemColor: Colors.grey[600],
        items: [

          SalomonBottomBarItem(
            icon: const Icon(Icons.timeline),
            title: const Text("History"),
            selectedColor: Colors.blueAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.location_on),
            title: const Text("Branches"),
            selectedColor: Colors.blueAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.tune),
            title: const Text("Settings"),
            selectedColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
