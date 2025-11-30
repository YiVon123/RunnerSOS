import 'package:flutter/material.dart';
import 'package:runner_sos/widgets/common/app_page.dart';
import 'package:runner_sos/widgets/common/runner_bottom_nav.dart';

class RunnerHomepage extends StatefulWidget {
  const RunnerHomepage({super.key});

  @override
  State<RunnerHomepage> createState() => _RunnerHomepageState();
}

class _RunnerHomepageState extends State<RunnerHomepage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      showBackButton: true,
      onQrPressed: () {},
      bottomBar: RunnerBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      child: Column(children: [Text("runner homepage")]),
    );
  }
}
