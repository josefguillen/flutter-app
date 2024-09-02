import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/features/presentation/user_details_screen/bloc/user_details_state.dart';

class UserDetailsBloc extends Cubit<UserDetailsState> {
  UserDetailsBloc() : super(const UserDetailsState());
}