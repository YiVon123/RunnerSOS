import 'package:flutter/material.dart';
import 'package:runner_sos/ui/runner/runner_activity_screen.dart';
import 'package:runner_sos/ui/runner/runner_homepage.dart';
import 'package:runner_sos/ui/runner/runner_profile.dart';
import 'package:runner_sos/utils/app_colors.dart';
import 'package:runner_sos/widgets/common/app_bar_builder.dart';

class RunnerShell extends StatefulWidget {
  const RunnerShell({super.key});

  State<RunnerShell> createState() => _RunnerShellState();
}

class _RunnerShellState extends State<RunnerShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    RunnerHomepage(),
    RunnerActivityScreen(),
    Placeholder(),
    RunnerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder.build(context: context, showQrButton: true),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: "Activity",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "My Event"),
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
