import 'package:either_dart/either.dart';
import 'package:flutterexamapp/core/model/failed_model.dart';
import 'package:flutterexamapp/core/model/success_model.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/domain/repository/person_repository.dart';

class GetNextPersonList {
  final PersonRepository personRepository;

  GetNextPersonList({required this.personRepository});

  Future<Either<FailedModel, SuccessModel<List<PersonModel>>>> invoke() async {
    return await personRepository.getNextPersonList();
  }
}