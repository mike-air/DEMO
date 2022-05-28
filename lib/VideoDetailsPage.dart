import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late VideoPlayerController _controller;
  late Future<void> initializeVideoPlayer;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('videos/video4.mp4');
    initializeVideoPlayer = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _controller.pause();
            });
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: FutureBuilder(
          future: initializeVideoPlayer,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),
                        ClosedCaption(text: _controller.value.caption.text),
                        VideoProgressIndicator(_controller,
                            allowScrubbing: true),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Container(
                      margin: EdgeInsets.all(3),
                      child: Text(
                        "SPIDERMAN VIEW MARVEL STUDIOS".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Text("3,007,200 views"),
                        ),
                        Text('${date.day},${date.month},${date.year}')
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        color: Colors.blue,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text("Like",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        color: Colors.white,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.thumb_down,
                            ),
                            SizedBox(width: 10,),
                            Text("dislike")
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),

                        child: Row(
                          children: const [
                            Icon(
                              Icons.share,
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.playlist_add,
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),

                        child: Row(
                          children: const [
                            Icon(
                              Icons.more_horiz,
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(_controller.value.isPlaying
            ? Icons.pause_circle
            : Icons.play_circle),
      ),
    );
  }
}
