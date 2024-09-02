import 'package:flutterexamapp/core/constants/constants.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/core/model/result_model.dart';
import 'package:flutterexamapp/features/data/api/person_client.dart';
import 'package:flutterexamapp/features/domain/entity/person/person_entity.dart';

abstract class PersonDataSource {
  Future<ResultModel<List<PersonEntity>>> getPersonList();
}

class PersonDataSourceImpl extends PersonDataSource {
  final PersonClient personClient;

  PersonDataSourceImpl({
    required this.personClient,
  });

  @override
  Future<ResultModel<List<PersonEntity>>> getPersonList() async {
    try {
      final res = await personClient.getPersonList(Constants.MAX_DATA_PER_FETCH);
      if (res.data.code == 200) {
        return ResultModel(
          isSuccess: true,
          data: res.data.data ?? [],
        );
      }
      else {
        return const ResultModel(
          isSuccess: false,
          message: Strings.failedToGetPersonList,
        );
      }
    } catch (_) {
      return const ResultModel(
        isSuccess: false,
        message: Strings.somethingWentWrong,
      );
    }
  }
}
