import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(const VideoApp(asset: 'assets/video.mp4',));

class VideoApp extends StatefulWidget {
  final String asset;
  const VideoApp({Key? key, required this.asset}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.asset)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller: _controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? Scaffold(
            appBar: buildAppBar(context),
            body: Container(
              alignment: Alignment.topCenter,
              child: buildVideo(),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black38,
              onPressed: () => Navigator.pop(context),
            ),
          );
  }

  Widget buildVideo() => buildVideoPlayer();

  buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller));
  }
}
