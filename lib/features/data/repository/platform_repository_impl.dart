import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:flutterexamapp/features/data/datasource/library/platform_datasource.dart';
import 'package:flutterexamapp/features/domain/repository/platform_repository.dart';

class PlatformRepositoryImpl extends PlatformRepository {
  final PlatformDataSource platformDataSource;

  PlatformRepositoryImpl({
    required this.platformDataSource,
  });

  @override
  PlatformTypeEnum getPlatformType() => platformDataSource.getPlatformType();
}
