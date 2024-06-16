import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String songPath;
  final String songTitle;

  AudioPlayerScreen({required this.songPath, required this.songTitle});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio(widget.songPath),
      autoStart: true,
    );
  }



  void _playPause() {
    _assetsAudioPlayer.playOrPause();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_arrow_down))
        ,
        title: Text(widget.songTitle),
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
        )),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              IconButton(
                iconSize: 64,
                icon: Icon(Icons.play_arrow),
                onPressed: _playPause,
              ),
              StreamBuilder(
                stream: _assetsAudioPlayer.isPlaying,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Text('Playing');
                  } else {
                    return Text('Paused');
                  }
                },
              ),

              // Row(
              //   children: [
              //     Icon(Icons.keyboard_arrow_down),
              //
              //
              //   ],
              // ),
              //
              // // Thumbnail and Title
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Column(
              //     children: [
              //       Image.asset(
              //         "assets/img/header.jpg", // Your image path
              //         height: 200,
              //       ),
              //       SizedBox(height: 16.0),
              //       Text(
              //         "Dil Ke Paas (Indian Version)",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 24,
              //           fontWeight: FontWeight.bold,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //       Text(
              //         "T-Series",
              //         style: TextStyle(
              //           color: Colors.white54,
              //           fontSize: 16,
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // // Seekbar
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("00:00", style: TextStyle(color: Colors.white)),
              //       Expanded(
              //         child: Slider(
              //           value: 0.0,
              //           onChanged: (value) {},
              //           activeColor: Colors.white,
              //           inactiveColor: Colors.white54,
              //         ),
              //       ),
              //       Text("04:25", style: TextStyle(color: Colors.white)),
              //     ],
              //   ),
              // ),
              // // Player Controls
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       IconButton(
              //         icon: Icon(Icons.skip_previous,
              //             color: Colors.white, size: 36),
              //         onPressed: () {},
              //       ),
              //       IconButton(
              //         icon:
              //             Icon(Icons.play_arrow, color: Colors.white, size: 36),
              //         onPressed: () {},
              //       ),
              //       IconButton(
              //         icon:
              //             Icon(Icons.skip_next, color: Colors.white, size: 36),
              //         onPressed: () {},
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // // Up Next
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Text(
              //     "Up Next",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // // Up Next Placeholder
              // Expanded(
              //   child: Center(
              //     child: Text(
              //       "Up Next Songs Placeholder",
              //       style: TextStyle(
              //         color: Colors.white54,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
