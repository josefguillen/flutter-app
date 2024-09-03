import 'package:either_dart/src/either.dart';
import 'package:flutterexamapp/core/constants/constants.dart';
import 'package:flutterexamapp/core/constants/strings.dart';
import 'package:flutterexamapp/core/model/failed_model.dart';
import 'package:flutterexamapp/core/model/success_model.dart';
import 'package:flutterexamapp/features/data/datasource/remote/person_datasource.dart';
import 'package:flutterexamapp/features/domain/mapper/person_entity_extension.dart';
import 'package:flutterexamapp/features/domain/model/person_model.dart';
import 'package:flutterexamapp/features/domain/repository/person_repository.dart';

class PersonRepositoryImpl extends PersonRepository {
  final PersonDataSource personDataSource;

  PersonRepositoryImpl({
    required this.personDataSource,
  });

  List<PersonModel> personList = [];
  int getAttemptCounter = 0;

  @override
  Future<Either<FailedModel, SuccessModel<List<PersonModel>>>>
      getInitialPersonList() async {
    personList.clear();
    getAttemptCounter = 0;
    final result = await personDataSource.getPersonList();
    if (result.isSuccess) {
      final list = result.data!.map((e) => e.mapToPersonModel()).toList();
      personList.addAll(list);
      getAttemptCounter++;
      return Right(
        SuccessModel(
          data: list.take(Constants.MAX_DISPLAY_ITEM).toList(),
          hasNextPage: true,
        ),
      );
    } else {
      return Left(FailedModel(message: result.message));
    }
  }

  @override
  Future<Either<FailedModel, SuccessModel<List<PersonModel>>>>
      getNextPersonList() async {
    if (getAttemptCounter <= Constants.MAX_API_REQUEST) {
      final totalItemsLoaded = Constants.MAX_DISPLAY_ITEM * getAttemptCounter;
      if (totalItemsLoaded == personList.length) {
        final result = await personDataSource.getPersonList();
        if (result.isSuccess) {
          final list = result.data!.map((e) => e.mapToPersonModel()).toList();
          personList.addAll(list);
          getAttemptCounter++;
          return Right(
            SuccessModel(
              data: list.take(Constants.MAX_DISPLAY_ITEM).toList(),
              hasNextPage: true,
            ),
          );
        }
      } else {
        final list = personList
            .skip(totalItemsLoaded)
            .take(Constants.MAX_DISPLAY_ITEM)
            .toList();
        getAttemptCounter++;
        return Right(
          SuccessModel(
            data: list,
            hasNextPage: getAttemptCounter < Constants.MAX_API_REQUEST,
          ),
        );
      }
    }
    return const Left(
      FailedModel(
        message: Strings.failedToLoadNextItems,
      ),
    );
  }
}
