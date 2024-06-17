import 'package:flutter/material.dart';
import 'package:music_app/Providers/Audio_Player_Provider.dart';
import 'package:music_app/model/Main_List.dart';
import 'package:provider/provider.dart';
import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  final List songList;
  final int initialIndex;

  AudioPlayerScreen({
    required this.songList,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // AudioPlayerProvider audioPlayerProvider = Provider.of<AudioPlayerProvider>(context,listen: false);
    final musicProviderfalse =
        Provider.of<MusicProvider>(context, listen: false);
    final musicProviderTrue = Provider.of<MusicProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_down),
        ),
        title: Text(
            musicProviderTrue.mainList[musicProviderTrue.currentIndex]['name']),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(musicProviderTrue
                                .mainList[musicProviderTrue.currentIndex]
                            ['image']),fit: BoxFit.cover
                    )
                ),
              ),
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
                    value: musicProviderTrue.currentPosition.inMilliseconds
                        .toDouble(),
                    min: 0.0,
                    max: musicProviderTrue.totalDuration.inMilliseconds
                        .toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey.shade700,
                    onChanged: (value) {
                      musicProviderTrue
                          .seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        musicProviderTrue
                            .formatDuration(musicProviderTrue.currentPosition),
                        style: Theme.of(context).textTheme.labelSmall),
                    Text(
                      musicProviderTrue
                          .formatDuration(musicProviderTrue.totalDuration),
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
                    onPressed: () => musicProviderfalse
                        .previousSong(musicProviderfalse.mainList),
                  ),
                  StreamBuilder(
                    stream: musicProviderTrue.assetsAudioPlayer.isPlaying,
                    builder: (context, asyncSnapshot) {
                      final bool isPlaying = asyncSnapshot.data ?? false;
                      return IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 30,
                        onPressed: musicProviderfalse.playPause,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next),
                    iconSize: 30,
                    onPressed: () => musicProviderfalse
                        .nextSong(musicProviderfalse.mainList),
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
