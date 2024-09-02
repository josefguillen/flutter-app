import 'package:equatable/equatable.dart';

class PersonListState extends Equatable {
  final bool reloadList;

  const PersonListState({
    this.reloadList = false,
  });

  PersonListState copyWith({
    bool? reloadList,
  }) =>
      PersonListState(
        reloadList: reloadList ?? this.reloadList,
      );

  @override
  List<Object?> get props => [
        reloadList,
      ];
}
