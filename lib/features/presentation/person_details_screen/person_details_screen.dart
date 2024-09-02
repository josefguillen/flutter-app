import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_image_viewer.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';

class PersonDetailsScreen extends StatelessWidget {
  final PersonModel data;

  const PersonDetailsScreen({
    required this.data,
    super.key,
  });

  static String routeName = "/userDetails";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Strings.titlePersonDetails.toUpperCase(),
      showBackButton: true,
      body: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppImageViewer(
                imageUrl: data.image,
                width: 120.w,
                height: 120.h,
              ),
              SizedBox(height: 10.h),
              Text(
                "${data.firstName} ${data.lastName}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
