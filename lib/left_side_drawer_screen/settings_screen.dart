import 'package:flare_video_player/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Color(secondaryColor)),
        ),
        iconTheme: IconThemeData(color: Color(secondaryColor)),
      ),
      body: ListView.builder(
        itemCount: settingsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (index == 0) goToTelegram();
              if (index == 1) goToWhatsapp();
              if (index == 2) {
                showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset(
                      'assets/AppLogo.png',
                      // fit: BoxFit.fitWidth,
                      scale: 6,
                    ),
                    applicationName: '',

                    // applicationVersion: '0.1',
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Column(
                        children: [
                          Text('Version: 0.1'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Developed by Bharath Chandran '),
                        ],
                      )),
                    ]);
              }
            },
            title: Text(settingsList[index]),
            leading: Icon(
              settingsIconList[index],
              color: Color(secondaryColor),
              size: 35,
            ),
          );
        },
      ),
    );
  }
}

List settingsList = [
  'Join Our Telegram Channel',
  'Join Our WhatsApp Group',
  'About'
];
List settingsIconList = [
  const IconData(0xf0586, fontFamily: 'MaterialIcons'),
  Icons.chat,
  Icons.info
];

goToTelegram() async {
  final Uri url = Uri.parse('https://t.me/+KnS47h7WBKM4ZTE9');
  await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
}

goToWhatsapp() async {
  final Uri url = Uri.parse('https://chat.whatsapp.com/E1FDFWIy1YV4YF1PCUc5Lg');
  await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
}
