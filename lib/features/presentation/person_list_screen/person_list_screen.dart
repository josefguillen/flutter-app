import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';

class PersonListScreen extends StatelessWidget {
  const PersonListScreen({super.key});

  static String routeName = "/userList";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: Strings.titlePersonList.toUpperCase(),
      body: Scrollbar(
        thickness: 2.w,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: const Column(
              children: [
                _ListContainer(),
                _BottomProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListContainer extends StatelessWidget {
  const _ListContainer();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    return BlocConsumer<PersonListBloc, PersonListState>(
      buildWhen: (prev, current) => prev.reloadList != current.reloadList,
      builder: (context, state) {
        final list = bloc.personList;
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, i) {
            return _ListItem(data: list[i]);
          },
        );
      },
      listener: (context, state) {},
    );
  }
}

class _ListItem extends StatelessWidget {
  final PersonModel data;

  const _ListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      height: 100.h,
      child: Card(
        elevation: 3.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: data.image,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(
                      width: 80.w,
                      height: 80.h,
                      color: Colors.black12,
                      child: Center(
                        child: SizedBox(
                          width: 10.h,
                          height: 10.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                          ),
                        ),
                      ),
                    );
                  },
                  errorWidget: (_, __, ___) {
                    return Container(
                      width: 80.w,
                      height: 80.h,
                      color: Colors.black12,
                    );
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.firstName} ${data.lastName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(data.email),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomProgressIndicator extends StatelessWidget {
  const _BottomProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

