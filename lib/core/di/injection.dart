import 'package:dio/dio.dart';
import 'package:flutterexamapp/core/interceptors/api_interceptor.dart';
import 'package:flutterexamapp/features/data/api/person_client.dart';
import 'package:flutterexamapp/features/data/datasource/library/platform_datasource.dart';
import 'package:flutterexamapp/features/data/datasource/remote/person_datasource.dart';
import 'package:flutterexamapp/features/data/repository/person_repository_impl.dart';
import 'package:flutterexamapp/features/data/repository/platform_repository_impl.dart';
import 'package:flutterexamapp/features/domain/repository/person_repository.dart';
import 'package:flutterexamapp/features/domain/repository/platform_repository.dart';
import 'package:flutterexamapp/features/domain/usercase/person/get_initial_person_list.dart';
import 'package:flutterexamapp/features/domain/usercase/person/get_next_person_list.dart';
import 'package:flutterexamapp/features/domain/usercase/person_list_feature_usecase.dart';
import 'package:flutterexamapp/features/domain/usercase/platform/get_platform_type.dart';
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
  vf.registerLazySingleton<PlatformDataSource>(() => PlatformDataSourceImpl());

  //REPOSITORY
  vf.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      personDataSource: vf.call(),
    ),
  );
  vf.registerLazySingleton<PlatformRepository>(
    () => PlatformRepositoryImpl(
      platformDataSource: vf.call(),
    ),
  );

  //USE CASE
  vf.registerLazySingleton<PersonListFeatureUseCase>(
    () => PersonListFeatureUseCase(
      getNextPersonList: GetNextPersonList(personRepository: vf.call()),
      getInitialPersonList: GetInitialPersonList(personRepository: vf.call()),
      getPlatformType: GetPlatformType(platformRepository: vf.call()),
    ),
  );

  //BLOC
  vf.registerLazySingleton<PersonListBloc>(
    () => PersonListBloc(
      personListFeatureUseCase: vf.call(),
    ),
  );
}
