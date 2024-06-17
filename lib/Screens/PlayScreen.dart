import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<String> songList;
  final int initialIndex;

  AudioPlayerScreen({
    required this.songList,
    required this.initialIndex,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  late int currentIndex;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _openSong(widget.songList[currentIndex]);

    _assetsAudioPlayer.currentPosition.listen((duration) {
      setState(() {
        currentPosition = duration;
      });
    });

    _assetsAudioPlayer.current.listen((playingAudio) {
      setState(() {
        totalDuration = playingAudio?.audio.duration ?? Duration.zero;
      });
    });
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

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [
      if (hours > 0) hours,
      minutes,
      seconds,
    ].map(twoDigits).join(':');
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbColor: Colors.white,
                    trackHeight: 1.5,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
                  ),
                  child: Slider(
                    value: currentPosition.inMilliseconds.toDouble(),
                    min: 0.0,
                    max: totalDuration.inMilliseconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey.shade700,
                    onChanged: (value) {
                      _assetsAudioPlayer.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatDuration(currentPosition),
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                      formatDuration(totalDuration),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
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
