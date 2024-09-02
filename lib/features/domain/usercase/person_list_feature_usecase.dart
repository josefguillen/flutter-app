import 'package:flutterexamapp/features/domain/usercase/person/get_initial_person_list.dart';
import 'package:flutterexamapp/features/domain/usercase/person/get_next_person_list.dart';
import 'package:flutterexamapp/features/domain/usercase/platform/get_platform_type.dart';

class PersonListFeatureUseCase {
  final GetInitialPersonList getInitialPersonList;
  final GetNextPersonList getNextPersonList;
  final GetPlatformType getPlatformType;

  PersonListFeatureUseCase({
    required this.getNextPersonList,
    required this.getInitialPersonList,
    required this.getPlatformType,
  });
}
