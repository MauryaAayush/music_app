import 'package:flutter/material.dart';
import 'package:music_app/Providers/Audio_Player_Provider.dart';
import 'package:music_app/Providers/page_provider.dart';
import 'package:music_app/Providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/Main_Screen.dart';

void main() {

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PageProvider(),
      ),
      ChangeNotifierProvider(create: (_) => AudioPlayerProvider())

    ], child: const MusicApp()),
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
      home: const HomeScreen(),
    );
  }
}
