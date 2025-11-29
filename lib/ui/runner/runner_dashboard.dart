import 'package:flutter/material.dart';

class RunnerDashboard extends StatefulWidget {
  const RunnerDashboard({super.key});

  @override
  State<RunnerDashboard> createState() => _RunnerDashboardState();
}

class _RunnerDashboardState extends State<RunnerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Runner Dashboard")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(children: [
            
          ],
        ),
      ),
    );
  }
}
