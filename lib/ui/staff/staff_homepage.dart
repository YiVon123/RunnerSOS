import 'package:flutter/material.dart';
import 'package:runner_sos/widgets/common/app_page.dart';

class StaffHomepage extends StatefulWidget {
  const StaffHomepage({super.key});

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(child: Column(children: [Text("staff")]));
  }
}
