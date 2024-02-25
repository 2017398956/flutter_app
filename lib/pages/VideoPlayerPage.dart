import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<StatefulWidget> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    const videoPath1 = "https://v-cdn.zjol.com.cn/280443.mp4";
    const videoPath2 = "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8";
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoPath1))
      ..initialize().then((a) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('视频测试'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const SizedBox(
                width: 100,
                height: 100,
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.all(5)),
                    Text("视频加载中...")
                  ],
                )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
