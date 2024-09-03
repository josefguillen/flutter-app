import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/colors.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/core/utility/utility.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_image_viewer.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_shader.dart';

class PersonDetailsScreen extends StatelessWidget {
  final PersonModel data;

  const PersonDetailsScreen({
    required this.data,
    super.key,
  });

  static String routeName = "/userDetails";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AppScaffold(
      title: Strings.titlePersonDetails.toUpperCase(),
      showBackButton: true,
      body: Container(
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
        //padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            AppImageViewer(
              imageUrl: data.image,
              width: 100.h,
              height: 100.h,
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: width,
              alignment: Alignment.center,
              child: Text(
                "${data.firstName} ${data.lastName}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.h,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      _ItemContainer(
                        label: Strings.username,
                        value: data.username,
                        icon: Icons.person_2_outlined,
                      ),
                      SizedBox(height: 10.h),
                      _ItemContainer(
                        label: Strings.email,
                        value: data.email,
                        shadeValue: true,
                        onValuePress: () {
                          Utility.launch(data.email);
                        },
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(height: 10.h),
                      _ItemContainer(
                        label: Strings.ip,
                        value: data.ip,
                        icon: Icons.info_outline,
                      ),
                      SizedBox(height: 10.h),
                      _ItemContainer(
                        label: Strings.macAddress,
                        value: data.macAddress,
                        icon: Icons.info_outline,
                      ),
                      SizedBox(height: 10.h),
                      _ItemContainer(
                        label: Strings.website,
                        value: data.website,
                        shadeValue: true,
                        onValuePress: () {
                          Utility.launch(data.website);
                        },
                        icon: Icons.link_sharp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemContainer extends StatelessWidget {
  final String label;
  final String value;
  final bool shadeValue;
  final IconData icon;
  final Function()? onValuePress;

  const _ItemContainer({
    required this.label,
    required this.value,
    required this.icon,
    this.shadeValue = false,
    this.onValuePress,
  });

  @override
  Widget build(BuildContext context) {
    Widget? valWidget = Text(
      value,
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.5.h,
      ),
    );

    return Row(
      children: [
        AppShader(
          widget: Icon(
            icon,
            size: 15.h,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 10.5.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Expanded(child: SizedBox()),
        InkWell(
          onTap: () {
            if (onValuePress != null) {
              onValuePress!();
            }
          },
          child: shadeValue ? AppShader(widget: valWidget) : valWidget,
        )
      ],
    );
  }
}
