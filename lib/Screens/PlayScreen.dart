import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String songPath;
  final String songTitle;

  AudioPlayerScreen({required this.songPath, required this.songTitle});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio(widget.songPath),
      autoStart: true,
    );
  }

  void _playPause() {
    _assetsAudioPlayer.playOrPause();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_down),
        ),
        title: Text(widget.songTitle),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Colors.grey.shade900, Colors.black]
                : [const Color(0xfff5f9ff), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: _assetsAudioPlayer.currentPosition,
                builder: (context, asyncSnapshot) {
                  final Duration currentPosition = asyncSnapshot.data ?? Duration.zero;
                  return Row(
                    children: [
                      Text(
                        ' ${currentPosition.toString().split('.').first}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      StreamBuilder(
                        stream: _assetsAudioPlayer.current,
                        builder: (context, asyncSnapshot) {
                          final Playing? current = asyncSnapshot.data;
                          final Duration? totalDuration = current?.audio.duration;
                          return Row(
                            children: [
                              SizedBox(
                                width: 250,
                                child: Slider(
                                  value: currentPosition.inSeconds.toDouble(),
                                  min: 0,
                                  max: totalDuration?.inSeconds.toDouble() ?? 1,
                                  onChanged: (value) {
                                    _assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                                  },
                                ),
                              ),
                              Text(
                                totalDuration?.toString().split('.').first ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: _assetsAudioPlayer.isPlaying,
                    builder: (context, asyncSnapshot) {
                      final bool isPlaying = asyncSnapshot.data ?? false;
                      return IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 64,
                        onPressed: _playPause,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
