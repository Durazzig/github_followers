import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM dd, yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static Future<void> openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
