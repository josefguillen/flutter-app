import 'package:equatable/equatable.dart';
import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';

class PersonListState extends Equatable {
  final bool reloadList;
  final PersonListActionEnum action;
  final PersonModel? selectedItem;
  final PlatformTypeEnum? platformType;
  final bool isLoading;
  final bool isError;
  final String message;

  const PersonListState({
    this.reloadList = false,
    this.action = PersonListActionEnum.initial,
    this.selectedItem,
    this.platformType,
    this.isLoading = false,
    this.isError = false,
    this.message = "",
  });

  PersonListState copyWith({
    bool? reloadList,
    PersonListActionEnum? action,
    PersonModel? selectedItem,
    PlatformTypeEnum? platformType,
    bool? isLoading,
    bool? isError,
    String? message,
  }) =>
      PersonListState(
        reloadList: reloadList ?? this.reloadList,
        action: action ?? this.action,
        selectedItem: selectedItem ?? this.selectedItem,
        platformType: platformType ?? this.platformType,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        reloadList,
        action,
        selectedItem,
        platformType,
        isLoading,
        isError,
        message,
      ];
}
