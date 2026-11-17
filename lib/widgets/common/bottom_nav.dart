
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenzo/core/constants/AppColor.dart';
import 'package:zenzo/screens/CartScreen.dart';
import 'package:zenzo/screens/HomeScreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  final List<IconData> icons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.cart_fill,
  ];

  void _goToHome() {
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Homescreen(),
      CartScreen(onContinueShopping: _goToHome),
    ];

    return Scaffold(
      extendBody: true,
      body: pages[selectedIndex],

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: 18,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (index) {
              final bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icons[index],
                    color: isSelected
                        ? AppColors.brownDark
                        : AppColors.lightGrayDarker,
                    size: isSelected ? 25 : 23,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
