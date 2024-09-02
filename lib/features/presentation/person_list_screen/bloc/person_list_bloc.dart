import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/domain/usecase/person_list_feature_usecase.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';

enum PersonListActionEnum {
  initial,
  goToDetailPage,
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
      populateInitList();
    }
  }

  Future<void> populateInitList() async {
    final result = await personListFeatureUseCase.getInitialPersonList.invoke();
    result.fold(
      (failed) {},
      (success) {
        personList.addAll(success.data ?? []);
        reloadList();
      },
    );
  }

  Future<void> populateNextList() async {
    final result = await personListFeatureUseCase.getInitialPersonList.invoke();
    result.fold(
      (failed) {},
      (success) {
        personList.addAll(success.data ?? []);
        reloadList();
      },
    );
  }

  void reloadList() {
    emit(state.copyWith(reloadList: !state.reloadList));
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

}
