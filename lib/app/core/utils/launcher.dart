import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// launch call via url launcher
Future launch(String url) async {
  final parse = Uri.parse(url);
  if (await url_launcher.canLaunchUrl(parse)) {
    url_launcher.launchUrl(parse);
  } else {
    Get.snackbar('Ooops...', 'Can not launch url');
  }
}
