import 'package:flutter/material.dart';
import 'package:music_app/Providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'Screens/Home_Screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      )
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


