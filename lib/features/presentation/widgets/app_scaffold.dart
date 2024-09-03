import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBackButton;
  final bool showRefreshButton;
  final Function()? onRefreshPress;

  const AppScaffold({
    required this.title,
    required this.body,
    this.showBackButton = false,
    this.showRefreshButton = false,
    this.onRefreshPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleBarHeight = AppBar().preferredSize.height;
    final containerHeight = MediaQuery.of(context).size.height - titleBarHeight;
    final containerWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: Visibility(
            visible: showBackButton,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          actions: [
            Visibility(
              visible: showRefreshButton,
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh,
                  ),
                  onPressed: () {
                    if (onRefreshPress != null) {
                      onRefreshPress!();
                    }
                  },
                )
            ),
          ],
        ),
        body: SizedBox(width: containerWidth, height: containerHeight, child: body),
      ),
    );
  }
}
