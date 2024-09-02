import 'package:flutter/material.dart';
import 'package:flutterexamapp/core/constants/strings.dart';

class AppNotSupportedWidget extends StatelessWidget {
  const AppNotSupportedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: const Center(
          child: Text(Strings.platformNotSupported),
        ),
      ),
    );
  }
}
