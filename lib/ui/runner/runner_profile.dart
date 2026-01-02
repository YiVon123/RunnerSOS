import 'package:flutter/material.dart';
import 'package:runner_sos/widgets/common/app_page.dart';

class RunnerProfileScreen extends StatefulWidget {
  const RunnerProfileScreen({super.key});

  State<RunnerProfileScreen> createState() => _RunnerProfileScreenState();
}

class _RunnerProfileScreenState extends State<RunnerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('profile')],
      ),
    );
  }
}
