import 'package:flutter/material.dart';
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
        children: const [
          VideoPlayerView(
              url: "videos/test_and_pencils.mp4",
              dataSourceType: DataSourceType.asset),
          SizedBox(
            height: 10.0,
          ),
          VideoPlayerView(
              url:
                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
              dataSourceType: DataSourceType.network)
        ],
      ),
    );
  }
}
