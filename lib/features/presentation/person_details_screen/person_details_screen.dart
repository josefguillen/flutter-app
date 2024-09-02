import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({super.key});

  static String routeName = "/userDetails";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Strings.titlePersonDetails.toUpperCase(),
      showBackButton: true,
      body: Scrollbar(
        thickness: 2.w,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: const Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
}
