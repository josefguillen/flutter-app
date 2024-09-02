import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt vf = GetIt.instance;
Future<void> init() async {

  vf.registerLazySingleton<PersonListBloc>(() => PersonListBloc());
  vf.registerFactory<PersonListBloc>(() => PersonListBloc());

}