import 'package:flutter/material.dart';
import 'package:runner_sos/utils/app_colors.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const AppPage({Key? key, required this.child, this.padding})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
