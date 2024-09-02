import 'package:either_dart/either.dart';
import 'package:flutterexamapp/core/model/failed_model.dart';
import 'package:flutterexamapp/core/model/success_model.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';

abstract class PersonRepository {
  Future<Either<FailedModel, SuccessModel<List<PersonModel>>>> getInitialPersonList();
  Future<Either<FailedModel, SuccessModel<List<PersonModel>>>> getNextPersonList();
}