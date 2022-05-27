import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(VideoApp());

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
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
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black38,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Container(
              alignment: Alignment.topCenter,
              child: buildVideo(),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() => buildVideoPlayer();

  buildVideoPlayer() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: VideoPlayer(controller));
  }
}
