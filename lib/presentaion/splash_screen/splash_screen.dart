import 'package:flare_video_player/infrastructure/directory_fetch_fuction.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: waitForPermission(context: context),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Image.asset(
                'assets/Flare.gif',
                fit: BoxFit.fill,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  
}
