import 'package:url_launcher/url_launcher.dart';

class Utility {
  static void launch(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) {}
    } catch (_) {}
  }
}
