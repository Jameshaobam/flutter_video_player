import 'package:flutter/material.dart';
import 'package:videoplayer_test/widgets/video_player_view.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});
  static const String routeName = "/second-page";
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page"),
      ),
      body: Column(children: const [
        Text("Text1"),
        Text("Text2"),
        Text("Text3"),
      ]),
    );
  }
}
