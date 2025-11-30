import 'package:flutter/material.dart';
import 'package:runner_sos/utils/app_colors.dart';

class RunnerBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const RunnerBottomNav({super.key, this.selectedIndex = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.button,
      unselectedItemColor: AppColors.medium,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          label: "Activity",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: "My Event"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
