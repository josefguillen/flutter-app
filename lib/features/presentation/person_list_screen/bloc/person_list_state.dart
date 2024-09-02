import 'package:equatable/equatable.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';

class PersonListState extends Equatable {
  final bool reloadList;
  final PersonListActionEnum action;
  final PersonModel? selectedItem;

  const PersonListState({
    this.reloadList = false,
    this.action = PersonListActionEnum.initial,
    this.selectedItem,
  });

  PersonListState copyWith({
    bool? reloadList,
    PersonListActionEnum? action,
    PersonModel? selectedItem,
  }) =>
      PersonListState(
        reloadList: reloadList ?? this.reloadList,
        action: action ?? this.action,
        selectedItem: selectedItem ?? this.selectedItem,
      );

  @override
  List<Object?> get props => [
        reloadList,
        action,
        selectedItem,
      ];
}
