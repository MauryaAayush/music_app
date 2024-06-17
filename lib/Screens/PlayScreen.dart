import 'package:flutter/material.dart';
import 'package:music_app/Providers/Audio_Player_Provider.dart';
import 'package:provider/provider.dart';
import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  final List songList;
  final int initialIndex;

  const AudioPlayerScreen({
    super.key,
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
      body: SafeArea(
        child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_down),
                    ),
        
        
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.lyrics),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.more_vert),
                    ),
        
                  ],
                ),
        
                Spacer(),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(musicProviderTrue
                              .mainList[musicProviderTrue.currentIndex]['image']),
                          fit: BoxFit.cover)),
                ),
                Spacer(),
        
                Text(musicProviderTrue
                    .mainList[musicProviderTrue.currentIndex]['name'],style: TextStyle(
                    fontSize: 30
                ),),
                Text('T-series'),
                Spacer(),
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.shuffle)),
                    IconButton(
                      icon: Icon(Icons.skip_previous_rounded),
                      iconSize: 45,
                      onPressed: () => musicProviderfalse
                          .previousSong(musicProviderfalse.mainList),
                    ),
                    StreamBuilder(
                      stream: musicProviderTrue.assetsAudioPlayer.isPlaying,
                      builder: (context, asyncSnapshot) {
                        final bool isPlaying = asyncSnapshot.data ?? false;
                        return IconButton(
                          icon: Icon(isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill),
                          iconSize: 75,
                          onPressed: musicProviderfalse.playPause,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next_rounded),
                      iconSize: 45,
                      onPressed: () => musicProviderfalse
                          .nextSong(musicProviderfalse.mainList),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.repeat)),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "UP NEXT",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "LYRICS",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "RELATED",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
