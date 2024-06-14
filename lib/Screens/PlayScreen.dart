import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Audio Player'),
        backgroundColor: Colors.transparent,
        // themeProvider.isDarkMode
        //     ? [Colors.grey.shade900, Colors.black]
        //     : [const Color(0xfff5f9ff), Colors.white],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Colors.grey.shade900, Colors.black]
                : [const Color(0xfff5f9ff), Colors.white],
            // Light mode gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Album Art and Song Info
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Image.network(''),
                    
                   Image.asset('assets/img/header.jpg'),
                    SizedBox(height: 16.0),
                    Text(
                      'Dil Ke Paas (Indian Version)',
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
              // Slider and Time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Slider(
                      value: 0,
                      min: 0,
                      max: 100, // Replace with actual max duration in milliseconds
                      onChanged: (value) {},
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '00:00',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '04:25', // Replace with actual duration
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Playback Controls
              Spacer(),
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
                      icon: Icon(Icons.play_arrow, size: 32.0),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next,size: 32.0),
                      onPressed: () {},
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
