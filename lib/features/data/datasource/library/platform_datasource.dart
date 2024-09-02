import 'package:flutterexamapp/core/enums/platform_type_enum.dart';
import 'package:universal_platform/universal_platform.dart';

abstract class PlatformDataSource {
  PlatformTypeEnum getPlatformType();
}

class PlatformDataSourceImpl extends PlatformDataSource {
  @override
  PlatformTypeEnum getPlatformType() {
    if (UniversalPlatform.isWeb) {
      return PlatformTypeEnum.browser;
    }
    else if (UniversalPlatform.isAndroid) {
      return PlatformTypeEnum.android;
    }
    else if (UniversalPlatform.isIOS) {
      return PlatformTypeEnum.ios;
    }
    else {
      return PlatformTypeEnum.notSupported;
    }
  }

}