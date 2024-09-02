import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/domain/repository/platform_repository.dart';

class GetPlatformType {
  final PlatformRepository platformRepository;

  GetPlatformType({required this.platformRepository});

  PlatformTypeEnum invoke() => platformRepository.getPlatformType();
}
