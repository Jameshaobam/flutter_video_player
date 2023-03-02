import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:video_player/video_player.dart';

enum DataSourceType {
  asset,
  network,
  file,
  contentUri,
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView(
      {super.key, required this.url, required this.dataSourceType});
  final String url;
  final DataSourceType dataSourceType;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        // TODO: Handle this case.
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        // TODO: Handle this case.
        _videoPlayerController = VideoPlayerController.network(widget.url);
        break;
      case DataSourceType.file:
        // TODO: Handle this case.
        _videoPlayerController = VideoPlayerController.file(File(widget.url));
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
        // TODO: Handle this case.
        break;
    }
    _videoPlayerController.initialize();
    chewieInit();
  }

  Future<void> chewieInit() async {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      looping: true,
      showControls: true,

      customControls: MaterialControls(
        showPlayButton: false,
      )..createElement(),
      materialProgressColors: ChewieProgressColors(playedColor: Colors.red),
      //add additional option menu in the option dot three
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () {
              print('option1');
            },
            iconData: Icons.chat,
            title: 'Option1',
          ),
          OptionItem(
            onTap: () => debugPrint('Another option working!'),
            iconData: Icons.chat,
            title: 'Another localized title',
          ),
        ];
      },

      //subtitles
      subtitle: Subtitles([
        Subtitle(
          index: 0,
          start: Duration.zero,
          end: const Duration(seconds: 10),
          text: 'Hello from subtitles',
        ),
        Subtitle(
          index: 1,
          start: const Duration(seconds: 10),
          end: const Duration(seconds: 20),
          text: 'Whats up? :)',
        ),
      ]),
      subtitleBuilder: (context, subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  bool isPause = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.dataSourceType.name.toUpperCase()),
        const Divider(),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: _chewieController),
        ),
        const SizedBox(
          height: 7.0,
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _chewieController.dispose();
                  Duration currentPosition =
                      _videoPlayerController.value.position;
                  print(currentPosition);
                  Duration targetPosition =
                      currentPosition - const Duration(seconds: 5);

                  _videoPlayerController.seekTo(targetPosition);
                  chewieInit();
                });
              },
              child: const Icon(
                Icons.fast_rewind,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            TextButton(
                onPressed: () {
                  _chewieController.togglePause();
                  setState(() {
                    if (_chewieController.isPlaying) {
                      isPause = false;
                    } else {
                      isPause = true;
                    }
                  });
                  log(_chewieController.isPlaying.toString());
                },
                child: Icon(isPause ? Icons.play_arrow : Icons.pause)),
            const SizedBox(
              width: 15.0,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _chewieController.dispose();
                    Duration currentPosition =
                        _videoPlayerController.value.position;
                    print(currentPosition);
                    Duration targetPosition =
                        currentPosition + const Duration(seconds: 5);

                    _videoPlayerController.seekTo(targetPosition);
                    chewieInit();
                  });
                },
                child: const Icon(Icons.fast_forward)),
            const SizedBox(
              width: 15.0,
            ),
            TextButton(
                onPressed: () {
                  _chewieController.enterFullScreen();
                },
                child: const Icon(Icons.fullscreen)),
          ],
        ),
        const SizedBox(
          height: 7.0,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
