import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperMethods {
  String formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }

  String formatNumber(dynamic value) {
    if (value == null) return "";
    return NumberFormat('#,##0', 'en_US').format(value);
  }

  Future<void> makePhoneCall(String number) async {
    final Uri callUri = Uri(
      scheme: 'tel',
      path: number.trim(),
    );

    try {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(
          callUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print("Could not open dialer");
      }
    } catch (e) {
      print("Error launching dialer: $e");
    }
  }
}
