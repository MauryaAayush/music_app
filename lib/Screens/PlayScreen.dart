import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
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
            children: [
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset('assets/img/header.jpg'),
                    SizedBox(height: 16.0),
                    Text(
                      music1[_currentSongIndex]['title']!,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'T-Series',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Slider(
                      value: _currentPosition.inSeconds.toDouble(),
                      min: 0,
                      max: _totalDuration.inSeconds.toDouble(),
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        _assetsAudioPlayer.seek(position);
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_currentPosition),
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(_totalDuration - _currentPosition),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous, size: 32.0),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                     Icons.play_arrow,
                        size: 32.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next, size: 32.0),
                      onPressed: _next,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
