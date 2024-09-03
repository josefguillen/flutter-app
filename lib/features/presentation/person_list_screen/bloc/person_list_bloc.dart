import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/domain/usecase/person_list_feature_usecase.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';

enum PersonListActionEnum {
  initial,
  goToDetailPage,
  refreshFinish,
  refreshFailed,
  nextPageLoading,
  nextPageFinish,
  nextPageFailed,
  nextPageNoData,
}

class PersonListBloc extends Cubit<PersonListState> {
  final PersonListFeatureUseCase personListFeatureUseCase;

  PersonListBloc({
    required this.personListFeatureUseCase,
  }) : super(const PersonListState());

  List<PersonModel> personList = [];

  void initialize() {
    final platformType = personListFeatureUseCase.getPlatformType.invoke();
    emit(state.copyWith(platformType: platformType));
    if (platformType != PlatformTypeEnum.notSupported) {
      emit(state.copyWith(allowPullDown: true));
      populateInitList(fromInit: true);
    }
  }

  Future<void> populateInitList({bool fromInit = false}) async {
    personList.clear();
    if (fromInit) {
      emit(
        state.copyWith(
          isLoading: true,
          isError: false,
        ),
      );
    }
    final result = await personListFeatureUseCase.getInitialPersonList.invoke();
    result.fold(
      (failed) {
        emit(
          state.copyWith(
            action: !fromInit ? PersonListActionEnum.refreshFailed : PersonListActionEnum.initial,
            isLoading: false,
            isError: fromInit ? true : false,
            message: failed.message,
          ),
        );
      },
      (success) {
        personList.addAll(success.data ?? []);
        emit(
          state.copyWith(
            reloadList: !state.reloadList,
            action: !fromInit
                ? success.hasNextPage
                    ? PersonListActionEnum.refreshFinish
                    : PersonListActionEnum.nextPageNoData
                : PersonListActionEnum.initial,
            isLoading: false,
            isError: false,
            allowPullUp:
                state.platformType == PlatformTypeEnum.browser ? false : success.hasNextPage,
            hasMoreData: success.hasNextPage,
          ),
        );
      },
    );
    emit(state.copyWith(action: PersonListActionEnum.initial));
  }

  Future<void> populateNextList() async {
    emit(
      state.copyWith(
        isLoadMoreOngoing: true,
        isLoadMoreError: false,
      ),
    );
    final result = await personListFeatureUseCase.getNextPersonList.invoke();
    result.fold(
      (failed) {
        emit(
          state.copyWith(
            message: failed.message,
            action: PersonListActionEnum.nextPageFailed,
            isLoadMoreOngoing: false,
            isLoadMoreError: true,
          ),
        );
      },
      (success) {
        personList.addAll(success.data ?? []);
        emit(
          state.copyWith(
            reloadList: !state.reloadList,
            allowPullUp:
                state.platformType == PlatformTypeEnum.browser ? false : success.hasNextPage,
            action: success.hasNextPage
                ? PersonListActionEnum.nextPageFinish
                : PersonListActionEnum.nextPageNoData,
            hasMoreData: success.hasNextPage,
            isLoadMoreOngoing: false,
          ),
        );
      },
    );
    emit(state.copyWith(action: PersonListActionEnum.initial));
  }

  void onItemPress(PersonModel item) {
    emit(
      state.copyWith(
        action: PersonListActionEnum.goToDetailPage,
        selectedItem: item,
      ),
    );
    emit(state.copyWith(action: PersonListActionEnum.initial));
  }

  Future<void> onRefresh({bool fromInit = false}) async {
    if (!state.isLoading) {
      await populateInitList(fromInit: fromInit);
    }
  }

  Future<void> onLoadMore() async {
    await populateNextList();
  }
}
