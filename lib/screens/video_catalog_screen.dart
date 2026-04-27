import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/video_player_provider.dart';

class VideoPlayerPage extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerPage({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoPlayerProvider(videoUrl),
      child: const VideoPlayerPageContent(),
    );
  }
}

class VideoPlayerPageContent extends StatelessWidget {
  const VideoPlayerPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoPlayerProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //title: const Text('Recipe Video'),
        leading: BackButton(color: Colors.grey,),
        backgroundColor: Colors.transparent,
      ),
      body: provider.hasError
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  provider.errorMessage,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : provider.isInitialized && provider.chewieController != null
              ? Chewie(
                  controller: provider.chewieController!,
                )
              : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
    );
  }
}