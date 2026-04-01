import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerProvider extends ChangeNotifier {
  final String videoUrl;
  late VideoPlayerController videoController;
  ChewieController? chewieController;

  bool isInitialized = false;
  bool hasError = false;
  String errorMessage = '';

  VideoPlayerProvider(this.videoUrl) {
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await videoController.initialize();

      chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: true,           // Change to true if you want auto play
        looping: false,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error playing video: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      isInitialized = true;
      notifyListeners();
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
      notifyListeners();
      print("Video Error: $e");
    }
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoController.dispose();
    super.dispose();
  }
}