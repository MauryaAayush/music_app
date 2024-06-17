import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:music_app/Providers/Audio_Player_Provider.dart';
import 'package:music_app/Providers/page_provider.dart';
import 'package:music_app/Providers/theme_provider.dart';
import 'package:music_app/Screens/PlayScreen.dart';
import 'package:music_app/Screens/SearchScreen.dart';
import 'package:music_app/model/Music_List.dart';
import 'package:provider/provider.dart';
import 'Screens/Main_Screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MusicProvider(),
          // builder: (context,child)=> AudioPlayerScreen(songList: musicList, initialIndex: 0),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioPlayerProvider(),
          // builder: (context,child)=> AudioPlayerScreen(songList: musicList, initialIndex: 0),
        ),
      ],
      builder: (context, child) => const MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      // home: const HomeScreen(),
      routes: {
        '/': (context) => HomeScreen(),
        '/play': (context) =>
            AudioPlayerScreen(songList: musicList, initialIndex: 0),
        '/search': (context) => SearchScreen(),
      },
    );
  }
}
