import 'package:dio/dio.dart';
import 'package:flutterexamapp/core/interceptors/api_interceptor.dart';
import 'package:flutterexamapp/features/data/api/person_client.dart';
import 'package:flutterexamapp/features/data/datasource/person_datasource.dart';
import 'package:flutterexamapp/features/data/repository/person_repository_impl.dart';
import 'package:flutterexamapp/features/domain/repository/person_repository.dart';
import 'package:flutterexamapp/features/presentation/person_list_screen/bloc/person_list_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt vf = GetIt.instance;

Future<void> init() async {
  Dio dio = Dio();
  dio.interceptors.add(ApiInterceptor());

  //LIBRARY

  //API
  vf.registerLazySingleton<PersonClient>(() => PersonClient(dio));

  //DATASOURCE
  vf.registerLazySingleton<PersonDataSource>(() => PersonDataSourceImpl(personClient: vf.call()));

  //REPOSITORY
  vf.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      personDataSource: vf.call(),
    ),
  );

  //USE CASE

  //BLOC
  vf.registerLazySingleton<PersonListBloc>(() => PersonListBloc());
  vf.registerFactory<PersonListBloc>(() => PersonListBloc());
}
