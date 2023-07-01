import 'package:flare_video_player/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(secondaryColor)),
        title: Text(
          'Help',
          style: TextStyle(color: Color(secondaryColor)),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextButton(
            onPressed: () {
              goEmail();
            },
            child: const Text(
              '''We are here to help :)
  Contact me: bcemailid@gmail.com''',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

goEmail() async {
  final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'bcemailid@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Flare video Player related query',
      }));
  await launchUrl(emailLaunchUri);
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
