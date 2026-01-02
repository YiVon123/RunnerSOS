import 'package:flutter/material.dart';
import 'package:runner_sos/widgets/common/app_page.dart';

class MedicHomepage extends StatefulWidget {
  const MedicHomepage({super.key});

  State<MedicHomepage> createState() => _MedicHomepageState();
}

class _MedicHomepageState extends State<MedicHomepage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("medic")],
      ),
    );
  }
}
