import 'package:fclp_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherController {
  static Future<void> makePhoneCall() async {
    try {
      final url = Uri(scheme: 'tel', path: AppConstants.phoneNumber);
      if(await canLaunchUrl(url)){
        await launchUrl(url);
      } else{
        debugPrint("Can't Launch");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> youTubeLauncheUrl(String link) async {
    if (!await launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${link}');
    }
  }

  static Future<void> facebookLauncheUrl(String link) async {
    if (!await launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${link}');
    }
  }

  static Future<void> telegramLauncheUrl(String link) async {
    if (!await launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${link}');
    }
  }

  static Future<void> tiktokLaunchUrl(String link) async {
    if (!await launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch ${link}');
    }
  }
}
