import 'package:flutter/material.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:videoplayer_test/screens/second_screen.dart';
import 'package:videoplayer_test/widgets/video_player_view.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Player"),
      ),
      body: ListView(
        padding: EdgeInsets.all(7.0),
        children: [
          const VideoPlayerView(
              url: "videos/test_and_pencils.mp4",
              dataSourceType: DataSourceType.asset),
          const SizedBox(
            height: 10.0,
          ),
          const VideoPlayerView(
              url:
                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
              dataSourceType: DataSourceType.network),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, SecondPage.routeName);
              },
              child: const Text("Next")),
        ],
      ),
    );
  }
}
