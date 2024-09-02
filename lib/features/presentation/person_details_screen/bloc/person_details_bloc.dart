import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/features/presentation/person_details_screen/bloc/person_details_state.dart';

class PersonDetailsBloc extends Cubit<PersonDetailsState> {
  PersonDetailsBloc() : super(const PersonDetailsState());
}