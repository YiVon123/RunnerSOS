import 'package:flutter/material.dart';
import 'package:runner_sos/utils/app_colors.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final bool showQrButton;
  final VoidCallback? onQrPressed;
  final List<Widget>? actions;
  final Widget? bottomBar;

  const AppPage({
    Key? key,
    required this.child,
    this.showBackButton = false,
    this.showQrButton = false,
    this.onQrPressed,
    this.actions,
    this.bottomBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: showBackButton
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_circle_left),
              )
            : null,
        actions: [
          if (showQrButton)
            IconButton(
              onPressed: onQrPressed,
              icon: const Icon(Icons.qr_code_scanner),
            ),
          if (actions != null) ...actions!,
        ],
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),

      bottomNavigationBar: bottomBar,
    );
  }
}
