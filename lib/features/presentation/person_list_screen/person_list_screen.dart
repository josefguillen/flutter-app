import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterexamapp/core/constants/colors.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/person_details_screen/person_details_screen.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_image_viewer.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_not_supported_widget.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_scaffold.dart';
import 'package:flutterexamapp/features/presentation/widgets/app_shader.dart';
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
          prev.allowPullUp != current.allowPullUp ||
          prev.allowPullDown != current.allowPullDown,
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
            thickness: 1.5.h,
            child: SmartRefresher(
              physics: const BouncingScrollPhysics(),
              enablePullDown: state.allowPullDown,
              enablePullUp: state.allowPullUp,
              scrollController: scrollController,
              controller: refreshController,
              onRefresh: bloc.onRefresh,
              onLoading: bloc.onLoadMore,
              header: const WaterDropMaterialHeader(
                backgroundColor: colorSecondary,
              ),
              footer: CustomFooter(
                builder: (context, mode) {
                  if (mode == LoadStatus.idle) {
                    return const _BottomPullMessageIndicator(message: Strings.pullUpToLoad);
                  } else if (mode == LoadStatus.loading) {
                    return const _BottomLoadingIndicator();
                  } else if (mode == LoadStatus.failed) {
                    return const _BottomErrorIndicator(
                      message: "${Strings.somethingWentWrong}\n${Strings.pullUpToRetry}",
                      showRetryButton: false,
                    );
                  } else if (mode == LoadStatus.canLoading) {
                    return const _BottomPullMessageIndicator(message: Strings.releaseToLoadMore);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
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
          showRefreshButton: state.platformType == PlatformTypeEnum.browser,
          onRefreshPress: () => bloc.onRefresh(fromInit: true),
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
        child: AppShader(
          widget: CircularProgressIndicator(
            strokeWidth: 2.5.h,
          ),
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
        Text(
          bloc.state.message,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.5.h,
          ),
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          onPressed: () {
            bloc.populateInitList(fromInit: true);
          },
          child: AppShader(
            widget: Text(
              Strings.retry,
              style: TextStyle(
                fontSize: 12.5.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomIndicatorWidget extends StatelessWidget {
  const _BottomIndicatorWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    return BlocBuilder<PersonListBloc, PersonListState>(
      buildWhen: (prev, current) =>
          prev.hasMoreData != current.hasMoreData ||
          prev.platformType != current.platformType ||
          prev.isLoadMoreError != current.isLoadMoreError ||
          prev.isLoadMoreOngoing != current.isLoadMoreOngoing,
      builder: (context, state) {
        if (state.platformType == PlatformTypeEnum.browser && state.isLoadMoreOngoing) {
          return const _BottomLoadingIndicator();
        } else if (state.platformType == PlatformTypeEnum.browser && state.isLoadMoreError) {
          return _BottomErrorIndicator(message: state.message);
        } else if (state.platformType == PlatformTypeEnum.browser && state.hasMoreData) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            color: Colors.transparent,
            height: 40.h,
            child: TextButton(
              onPressed: bloc.onLoadMore,
              child: AppShader(
                widget: Text(
                  Strings.loadMore,
                  style: TextStyle(
                    fontSize: 12.5.h,
                  ),
                ),
              ),
            ),
          );
        } else if (!state.hasMoreData) {
          return const _BottomNoDataIndicator();
        }
        return const SizedBox();
      },
    );
  }
}

class _BottomLoadingIndicator extends StatelessWidget {
  const _BottomLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 5.h),
      color: Colors.transparent,
      height: 40.h,
      alignment: Alignment.center,
      child: SizedBox(
        width: 20.h,
        height: 20.h,
        child: AppShader(
          widget: CircularProgressIndicator(
            strokeWidth: 2.3.h,
          ),
        ),
      ),
    );
  }
}

class _BottomErrorIndicator extends StatelessWidget {
  final String message;
  final bool showRetryButton;

  const _BottomErrorIndicator({
    required this.message,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PersonListBloc>();
    final vPadding = bloc.state.platformType == PlatformTypeEnum.browser ? 5.h : 0.h;
    return Container(
      padding: EdgeInsets.symmetric(vertical: vPadding),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.5.h,
            ),
          ),
          if (showRetryButton)
            SizedBox(height: 2.h),
          if (showRetryButton)
            TextButton(
              onPressed: bloc.onLoadMore,
              child: AppShader(
                widget: Text(
                  Strings.retry,
                  style: TextStyle(fontSize: 12.5.h),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BottomNoDataIndicator extends StatelessWidget {
  const _BottomNoDataIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.h,
      child: Text(
        Strings.noMoreItemsToLoad,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.5.h,
        ),
      ),
    );
  }
}

class _BottomPullMessageIndicator extends StatelessWidget {
  final String message;

  const _BottomPullMessageIndicator({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Center(
        child: AppShader(
          widget: Text(
            message,
            style: TextStyle(
              fontSize: 12.5.h,
            ),
          ),
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

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
            refreshController.resetNoData();
            refreshController.refreshCompleted();
            break;
          case PersonListActionEnum.refreshFailed:
            refreshController.resetNoData();
            refreshController.refreshFailed();
            break;
          case PersonListActionEnum.nextPageFinish:
            refreshController.loadComplete();
            break;
          case PersonListActionEnum.nextPageFailed:
            refreshController.loadFailed();
            break;
          case PersonListActionEnum.nextPageLoading:
            refreshController.requestLoading();
            break;
          case PersonListActionEnum.nextPageNoData:
            refreshController.loadNoData();
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
          color: Colors.white,
          elevation: 3.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImageViewer(imageUrl: data.image, width: 80.h, height: 80.h),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          "${data.firstName} ${data.lastName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.h,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          data.email,
                          style: TextStyle(
                            fontSize: 10.h,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                AppShader(
                  widget: Icon(
                    Icons.keyboard_arrow_right,
                    size: 25.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
