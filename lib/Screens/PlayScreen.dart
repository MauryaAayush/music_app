import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<String> songList;
  final int initialIndex;

  AudioPlayerScreen(
      {required this.songList,
      required this.initialIndex,
      required String songPath, required String songTitle});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _openSong(widget.songList[currentIndex]);
  }

  void _openSong(String songPath) {
    _assetsAudioPlayer.open(
      Audio(songPath),
      autoStart: true,
      showNotification: true,
    );
  }

  void _playPause() {
    _assetsAudioPlayer.playOrPause();
  }

  void _nextSong() {
    if (currentIndex < widget.songList.length - 1) {
      setState(() {
        currentIndex++;
        _assetsAudioPlayer.stop();
        _openSong(widget.songList[currentIndex]);
      });
    }
  }

  void _previousSong() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _assetsAudioPlayer.stop();
        _openSong(widget.songList[currentIndex]);
      });
    }
  }

  // @override
  // void dispose() {
  //   _assetsAudioPlayer.dispose();
  //   super.dispose();
  // }

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
        title: Text('Song ${currentIndex + 1}'),
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
                  final Duration currentPosition =
                      asyncSnapshot.data ?? Duration.zero;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        ' ${currentPosition.toString().split('.').first}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      StreamBuilder(
                        stream: _assetsAudioPlayer.current,
                        builder: (context, asyncSnapshot) {
                          final Playing? current = asyncSnapshot.data;
                          final Duration? totalDuration =
                              current?.audio.duration;
                          return Row(

                            children: [
                              SizedBox(
                                width: 200,
                                child: Slider(
                                  value: currentPosition.inSeconds.toDouble(),
                                  min: 0,
                                  max: totalDuration?.inSeconds.toDouble() ?? 1,
                                  onChanged: (value) {
                                    _assetsAudioPlayer
                                        .seek(Duration(seconds: value.toInt()));
                                  },
                                ),
                              ),
                              Text(
                                totalDuration?.toString().split('.').first ??
                                    '',
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
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    iconSize: 30,
                    onPressed: _previousSong,
                  ),
                  StreamBuilder(
                    stream: _assetsAudioPlayer.isPlaying,
                    builder: (context, asyncSnapshot) {
                      final bool isPlaying = asyncSnapshot.data ?? false;
                      return IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 30,
                        onPressed: _playPause,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 30,
                    onPressed: _nextSong,
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
