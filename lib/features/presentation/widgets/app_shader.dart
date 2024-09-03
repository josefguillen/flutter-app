import 'package:flutter/cupertino.dart';
import 'package:flutterexamapp/core/constants/colors.dart';

class AppShader extends StatelessWidget {
  final Widget widget;

  const AppShader({
    required this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.2, 1],
        colors: [
          colorPrimary,
          colorSecondary,
        ],
      ).createShader(
        bounds,
      ),
      child: widget,
    );
  }
}
