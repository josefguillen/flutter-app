import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/person_details_screen/person_details_screen.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_image_viewer.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_not_supported_widget.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

RefreshController refreshController = RefreshController(
  initialRefresh: false,
);
ScrollController scrollController = ScrollController();

class PersonListScreen extends StatelessWidget {
  const PersonListScreen({super.key});

  static String routeName = "/userList";

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    return BlocBuilder<PersonListBloc, PersonListState>(
      buildWhen: (prev, current) =>
          prev.platformType != current.platformType ||
          prev.isLoading != current.isLoading ||
          prev.isError != current.isError ||
          prev.hasMoreData != current.hasMoreData,
      builder: (context, state) {
        if (state.platformType == PlatformTypeEnum.notSupported) {
          return const AppNotSupportedWidget();
        }
        Widget? widget;
        if (state.isLoading) {
          widget = const _Loading();
        } else if (state.isError) {
          widget = const _ErrorLoadWidget();
        } else {
          widget = Scrollbar(
            controller: scrollController,
            thickness: 3.w,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: state.hasMoreData,
              scrollController: scrollController,
              controller: refreshController,
              onRefresh: bloc.onRefresh,
              onLoading: bloc.onLoadMore,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: const Column(
                    children: [
                      _Actions(),
                      _ListContainer(),
                      _BottomIndicatorWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return AppScaffold(
          title: Strings.titlePersonList.toUpperCase(),
          body: widget,
        );
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20.h,
        height: 20.h,
        child: CircularProgressIndicator(
          strokeWidth: 2.w,
        ),
      ),
    );
  }
}

class _ErrorLoadWidget extends StatelessWidget {
  const _ErrorLoadWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(bloc.state.message),
        SizedBox(height: 5.h),
        ElevatedButton(
          onPressed: () {
            bloc.populateInitList(fromInit: true);
          },
          child: const Text(Strings.retry),
        ),
      ],
    );
  }
}

class _BottomIndicatorWidget extends StatelessWidget {
  const _BottomIndicatorWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListBloc, PersonListState>(
      buildWhen: (prev, current) => prev.hasMoreData != current.hasMoreData,
      builder: (context, state) {
        if (!state.hasMoreData) {
          return Container(
            alignment: Alignment.center,
            height: 40.h,
            child: const Text(
              Strings.noMoreItemsToLoad,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonListBloc, PersonListState>(
      child: const SizedBox(),
      listenWhen: (prev, current) => prev.action != current.action,
      listener: (context, state) {
        final action = state.action;
        switch (action) {
          case PersonListActionEnum.initial:
            break;
          case PersonListActionEnum.goToDetailPage:
            final item = state.selectedItem;
            context.pushNamed(PersonDetailsScreen.routeName, extra: item);
            break;
          case PersonListActionEnum.refreshFinish:
            refreshController.refreshCompleted();
            break;
          case PersonListActionEnum.refreshFailed:
            refreshController.refreshFailed();
            break;
          case PersonListActionEnum.nextPageFinish:
            refreshController.loadComplete();
            break;
          case PersonListActionEnum.nextPageFailed:
            refreshController.loadFailed();
            scrollToBottom();
            break;
          case PersonListActionEnum.nextPageLoading:
            refreshController.requestLoading();
            break;
        }
      },
    );
  }
}

class _ListContainer extends StatelessWidget {
  const _ListContainer();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    return BlocBuilder<PersonListBloc, PersonListState>(
      buildWhen: (prev, current) => prev.reloadList != current.reloadList,
      builder: (context, state) {
        final list = bloc.personList;
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, i) {
            return _ListItem(data: list[i]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 5.h);
          },
        );
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final PersonModel data;

  const _ListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    return InkWell(
      onTap: () {
        bloc.onItemPress(data);
      },
      child: SizedBox(
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
                AppImageViewer(imageUrl: data.image, width: 80.w, height: 80.h),
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
      ),
    );
  }
}
