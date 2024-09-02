import 'package:flutterexamapp/features/presentation/user_details_screen/bloc/user_details_bloc.dart';
import 'package:flutterexamapp/features/presentation/user_list_screen/bloc/user_list_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt vf = GetIt.instance;
Future<void> init() async {

  vf.registerLazySingleton<UserListBloc>(() => UserListBloc());
  vf.registerFactory<UserDetailsBloc>(() => UserDetailsBloc());

}