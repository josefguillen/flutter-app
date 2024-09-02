import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/features/domain/usercase/person/person_list_feature_usecase.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';

class PersonListBloc extends Cubit<PersonListState> {
  final PersonListFeatureUseCase personListFeatureUseCase;

  PersonListBloc({
    required this.personListFeatureUseCase,
  }) : super(const PersonListState());
}
