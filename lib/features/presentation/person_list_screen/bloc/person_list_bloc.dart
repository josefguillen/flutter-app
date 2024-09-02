import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/domain/usercase/person/person_list_feature_usecase.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';

class PersonListBloc extends Cubit<PersonListState> {
  final PersonListFeatureUseCase personListFeatureUseCase;

  PersonListBloc({
    required this.personListFeatureUseCase,
  }) : super(const PersonListState());

  List<PersonModel> personList = [];

  void initialize() {
    populateInitList();
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

}
