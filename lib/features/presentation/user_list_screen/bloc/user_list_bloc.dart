import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterexamapp/features/presentation/user_list_screen/bloc/user_list_state.dart';

class UserListBloc extends Cubit<UserListState> {
  UserListBloc() : super(const UserListState());
}