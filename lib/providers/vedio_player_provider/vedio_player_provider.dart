import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoPlayerProvider = StateNotifierProvider<VideoPlayerNotifier, VideoPlayerState>((ref) {
  return VideoPlayerNotifier();
});


class VideoPlayerNotifier extends StateNotifier<VideoPlayerState> {
  VideoPlayerNotifier() : super(VideoPlayerState());

  Future<void> initializeControllerFromFile(File videoFile) async {
    final controller = VideoPlayerController.file(videoFile);
    await controller.initialize();
    state = state.copyWith(controller: controller, isInitialized: true);
  }

  Future<void> initializeControllerFromUrl(String url) async {
    final controller = VideoPlayerController.network(url);
    await controller.initialize();
    state = state.copyWith(controller: controller, isInitialized: true);
  }

  void togglePlayPause() {
    if (state.controller != null) {
      if (state.isPlaying) {
        state.controller!.pause();
      } else {
        state.controller!.play();
      }
      state = state.copyWith(isPlaying: !state.isPlaying);
    }
  }

  @override
  void dispose() {
    super.dispose();
    state.controller?.dispose();
  }
}

class VideoPlayerState {
  final VideoPlayerController? controller;
  final bool isPlaying;
  final bool isInitialized;

  VideoPlayerState({
    this.controller,
    this.isPlaying = false,
    this.isInitialized = false,
  });

  VideoPlayerState copyWith({
    VideoPlayerController? controller,
    bool? isPlaying,
    bool? isInitialized,
  }) {
    return VideoPlayerState(
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

