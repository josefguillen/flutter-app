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
            action: !fromInit ? PersonListActionEnum.refreshFinish : PersonListActionEnum.initial,
            isLoading: false,
            isError: false,
            hasMoreData: success.hasNextPage,
          ),
        );
      },
    );
    emit(state.copyWith(action: PersonListActionEnum.initial));
  }

  Future<void> populateNextList() async {
    final result = await personListFeatureUseCase.getNextPersonList.invoke();
    result.fold(
      (failed) {
        emit(
          state.copyWith(
            message: failed.message,
            action: PersonListActionEnum.nextPageFailed,
          ),
        );
      },
      (success) {
        personList.addAll(success.data ?? []);
        emit(
          state.copyWith(
            reloadList: !state.reloadList,
            hasMoreData: success.hasNextPage,
            action: PersonListActionEnum.nextPageFinish,
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

  Future<void> onRefresh() async {
    await populateInitList();
  }

  Future<void> onLoadMore() async {
    await populateNextList();
  }
}
