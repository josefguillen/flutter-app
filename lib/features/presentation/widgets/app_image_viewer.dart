import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageViewer extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double? progressHeight;
  final double? progressWidth;

  const AppImageViewer({
    required this.imageUrl,
    required this.width,
    required this.height,
    this.progressHeight,
    this.progressWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final progressH = progressHeight ?? 10.h;
    final progressW = progressWidth ?? 10.h;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            color: Colors.black12,
            child: Center(
              child: SizedBox(
                width: progressW,
                height: progressH,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                ),
              ),
            ),
          );
        },
        errorWidget: (_, __, ___) {
          return Container(
            width: width,
            height: height,
            color: Colors.black12,
          );
        },
      ),
    );
  }
}
