import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppBarBuilder {
  static PreferredSizeWidget build({
    required BuildContext context,
    bool showBackButton = false,
    bool showQrButton = false,
    List<Widget>? actions,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      actions: [
        if (showQrButton)
          IconButton(
            onPressed: () => print('qr'),
            icon: const Icon(Icons.qr_code_scanner),
          ),
        if (actions != null) ...actions!,
      ],
    );
  }
}
