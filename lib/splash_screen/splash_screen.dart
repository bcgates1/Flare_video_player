import 'package:flare_video_player/fetch_directory/directory_fetch_fuction.dart';
import 'package:flare_video_player/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // waitForPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: waitForPermission(),
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

  Future<void> waitForPermission() async {
    // await Future.delayed(const Duration(seconds: 2));

    await videoFetch();

    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((ctx) {
        return const HomeScreen();
      })));
    }
  }
}
