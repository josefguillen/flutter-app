import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_state.dart';

class PersonListBloc extends Cubit<PersonListState> {
  PersonListBloc() : super(const PersonListState());
}