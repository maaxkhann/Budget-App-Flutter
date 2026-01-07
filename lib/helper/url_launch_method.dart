import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlMethod(
  String url, {
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  final Uri uri = Uri.parse(url);

  if (!await canLaunchUrl(uri)) {
    throw 'Could not launch $url';
  }

  await launchUrl(uri, mode: mode);
}
