import 'package:flutter/material.dart';
import 'package:runner_sos/ui/medic/medic_homepage.dart';
import 'package:runner_sos/utils/app_colors.dart';
import 'package:runner_sos/widgets/common/app_bar_builder.dart';

class MedicShell extends StatefulWidget {
  const MedicShell({super.key});

  State<MedicShell> createState() => _MedicStateShell();
}

class _MedicStateShell extends State<MedicShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MedicHomepage(),
    Placeholder(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(context: context, showQrButton: true),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Homepage"),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: "Activity",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.button,
        unselectedItemColor: AppColors.medium,
      ),
    );
  }
}
