import 'package:flutter/material.dart';
import 'package:runner_sos/widgets/common/app_page.dart';
import 'package:runner_sos/widgets/common/staff_bottom_nav.dart';

class StaffHomepage extends StatefulWidget {
  const StaffHomepage({super.key});

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      showQrButton: true,
      onQrPressed: () {},
      bottomBar: StaffBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      child: Column(children: [Text("staff")]),
    );
  }
}
