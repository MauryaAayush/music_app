// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerProvider extends ChangeNotifier {
//
//   final AudioPlayer _player;
//
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//   bool _isPlaying = false;
//
//   AudioPlayerProvider() {
//
//     _player.durationStream.listen((duration) {
//       _duration = duration ?? Duration.zero;
//       notifyListeners();
//     });
//
//     _player.positionStream.listen((position) {
//       _position = position;
//       notifyListeners();
//     });
//
//     _player.playerStateStream.listen((state) {
//       _isPlaying = state.playing;
//       notifyListeners();
//     });
//   }
//
//   Duration get duration => _duration;
//   Duration get position => _position;
//   bool get isPlaying => _isPlaying;
//
//   String get durationText => _duration.toString().split('.').first;
//   String get positionText => _position.toString().split('.').first;
//
//   void playPause() {
//     if (_isPlaying) {
//       _player.pause();
//     } else {
//       _player.play();
//     }
//   }
//
//   void seek(Duration position) {
//     _player.seek(position);
//   }
// }