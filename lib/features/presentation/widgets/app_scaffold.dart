import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/colors.dart';
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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorPrimary,
                  colorSecondary,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15.h,
            ),
          ),
          centerTitle: true,
          leading: Visibility(
            visible: showBackButton,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20.h,
                color: Colors.white,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          actions: [
            Visibility(
              visible: showRefreshButton,
              child: Container(
                margin: EdgeInsets.only(right: 5.w),
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 25.h,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (onRefreshPress != null) {
                      onRefreshPress!();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                contentBackgroundPrimary,
                contentBackgroundSecondary,
              ],
            ),
          ),
          width: containerWidth,
          height: containerHeight,
          child: body,
        ),
      ),
    );
  }
}
