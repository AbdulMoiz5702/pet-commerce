import 'package:animals/view/common/custom_sizedBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import '../../providers/vedio_player_provider/vedio_player_provider.dart';

class VideoThumbnail extends ConsumerWidget {
  final dynamic source;
  const VideoThumbnail({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(videoPlayerProvider);
    if (!videoState.isInitialized) {
      if (source is File) {
        ref.read(videoPlayerProvider.notifier).initializeControllerFromFile(source);
      } else if (source is String) {
        ref.read(videoPlayerProvider.notifier).initializeControllerFromUrl(source);
      }
    }
    return Column(
      children: [
        if (!videoState.isInitialized)
          Center(child: CircularProgressIndicator()),
        if (videoState.isInitialized)
          GestureDetector(
            onTap: () {
              ref.read(videoPlayerProvider.notifier).togglePlayPause();
            },
            child: AspectRatio(
              aspectRatio: videoState.controller!.value.aspectRatio,
              child: VideoPlayer(videoState.controller!),
            ),
          ),
        const Sized(height: 0.02,),
        videoState.isPlaying
            ? IconButton(
          icon: Icon(Icons.pause),
          onPressed: () {
            ref.read(videoPlayerProvider.notifier).togglePlayPause();
          },
        )
            : IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            ref.read(videoPlayerProvider.notifier).togglePlayPause();
          },
        ),
      ],
    );
  }
}



