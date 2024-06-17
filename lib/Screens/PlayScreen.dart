import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/theme_provider.dart';
import '../Providers/audio_player_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  final List<String> songList;
  final int initialIndex;

  AudioPlayerScreen({
    required this.songList,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_down),
        ),
        title: Text('Song ${audioPlayerProvider.currentIndex + 1}'),
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
                    value: audioPlayerProvider.currentPosition.inMilliseconds.toDouble(),
                    min: 0.0,
                    max: audioPlayerProvider.totalDuration.inMilliseconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey.shade700,
                    onChanged: (value) {
                      audioPlayerProvider.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(audioPlayerProvider.formatDuration(audioPlayerProvider.currentPosition),
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                      audioPlayerProvider.formatDuration(audioPlayerProvider.totalDuration),
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
                    onPressed: () => audioPlayerProvider.previousSong(songList),
                  ),
                  StreamBuilder(
                    stream: audioPlayerProvider.isPlaying,
                    builder: (context, asyncSnapshot) {
                      final bool isPlaying = asyncSnapshot.data ?? false;
                      return IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 30,
                        onPressed: audioPlayerProvider.playPause,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 30,
                    onPressed: () => audioPlayerProvider.nextSong(songList),
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
