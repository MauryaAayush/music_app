import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class MiniPlayer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.isDarkMode
              ? [Colors.grey[800]!, Colors.black]
              : [const Color(0xfff5f9ff), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 70.0,
            height: 70.0,
            color: Colors.grey,
            child: Icon(Icons.music_note, color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Song Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    'Artist Name',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}