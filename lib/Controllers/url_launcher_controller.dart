import 'package:fclp_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherController {
  static Future<void> makePhoneCall() async {
    try {
      final url = Uri(scheme: 'tel', path: AppConstants.phoneNumber);
      await launchUrl(url);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> youTubeLauncheUrl() async {
    if (!await launchUrl(Uri.parse(AppConstants.youtubeUrl),
        mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${AppConstants.youtubeUrl}');
    }
  }

  static Future<void> facebookLauncheUrl() async {
    if (!await launchUrl(Uri.parse(AppConstants.facebookUrl),
        mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${AppConstants.facebookUrl}');
    }
  }

  static Future<void> telegramLauncheUrl() async {
    if (!await launchUrl(Uri.parse(AppConstants.telegramUrl),
        mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${AppConstants.telegramUrl}');
    }
  }

  static Future<void> tiktokLaunchUrl() async {
    if (!await launchUrl(Uri.parse(AppConstants.tiktokUrl),
        mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${AppConstants.tiktokUrl}');
    }
  }
}
