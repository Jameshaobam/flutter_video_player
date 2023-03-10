import 'package:flutter/material.dart';
import 'package:videoplayer_test/screens/second_screen.dart';
import './screens/video_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const VideoPlayerScreen(),
        SecondPage.routeName: (context) => const SecondPage(),
      },
    );
  }
}
