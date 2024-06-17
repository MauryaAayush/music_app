import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/Providers/Audio_Player_Provider.dart';
import 'package:music_app/model/Music_List.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';
import '../Screens/PlayScreen.dart';
import '../model/Main_List.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final musicProvider = Provider.of<MusicProvider>(context);
    final musicProviderfalse = Provider.of<MusicProvider>(context,listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AudioPlayerScreen(
            songList: musicProviderfalse.mainList,
            initialIndex: 0,
          ),
        ));
      },
      child: Container(
        height: 75.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Colors.grey[900]!, Colors.black]
                : [const Color(0xfff5f9ff), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(musicProvider.mainList[musicProvider.currentIndex]['image']),
                  fit: BoxFit
                      .cover, // Optional: to make the image cover the entire container
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      musicProvider.mainList[musicProvider.currentIndex]['name'],
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      'T-series',
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                musicProvider.isFavorited
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: musicProvider.isFavorited ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                musicProvider.toggleFavorite();
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_previous),
              onPressed: () {
                Provider.of<MusicProvider>(context, listen: false)
                    .previousSong(musicProviderfalse.mainList);
              },
            ),
        Consumer<MusicProvider>(
          builder: (context, musicProvider, child) {
            return IconButton(
              icon: Icon(
              // musicProvider.isPlaying ? Icons.pause :
                Icons.play_arrow),
              iconSize: 30,
              onPressed: musicProvider.playPause,
            );
          },
        ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                Provider.of<MusicProvider>(context, listen: false)
                    .nextSong(musicProviderfalse.mainList);
              },
            ),
          ],
        ),
      ),
    );
  }
}
