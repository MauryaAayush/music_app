import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Providers/theme_provider.dart';
import 'SliverAppBarForGeading.dart';
import 'SliverAppBarForSearch.dart';
import 'carousal_Column.dart';

class HomeScreenCode extends StatefulWidget {
  const HomeScreenCode({
    super.key,
    required this.scrollController,
    required this.containerWidth,
    required this.themeProvider,
  });

  final ScrollController scrollController;
  final double containerWidth;
  final ThemeProvider themeProvider;

  @override
  _HomeScreenCodeState createState() => _HomeScreenCodeState();
}

class _HomeScreenCodeState extends State<HomeScreenCode> {
  late AudioPlayer _audioPlayer;
  String? _currentSong;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSong(String song) async {
    if (_currentSong == song) {
      await _audioPlayer.stop();
      setState(() {
        _currentSong = null;
      });
    } else {
      await _audioPlayer.play(AssetSource(song));
      setState(() {
        _currentSong = song;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NestedScrollView(
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              const SliverForGreading(),
              SliverForSearch(
                  scrollController: widget.scrollController,
                  containerWidth: widget.containerWidth),
            ];
          },
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Playlists',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Center(child: Text('Favorite Songs')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Last Session',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                CarouselSlider(
                  items: const [
                    Carousal_Column(),
                    Carousal_Column(),
                    Carousal_Column(),
                    Carousal_Column(),
                  ],
                  options: CarouselOptions(
                    height: 310,
                    padEnds: false,
                    viewportFraction: 0.85,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                  ),
                ),
                ..._buildSection('Trending Now', 5),
                ..._buildSection('Top Charts', 5),
                ..._buildSection('New Released', 5),
                ..._buildSection('Radio Stations', 5, isCircle: true),
                ..._buildSection('Recommended Artist', 5, isCircle: true),
                ..._buildSection('Devotional', 5),
              ],
            ),
          ),
        ),
        Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.rotate(
                  angle: 22 / 7 * 2,
                  child: IconButton(
                    icon: const Icon(Icons.horizontal_split_rounded),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                IconButton(
                  icon: Icon(widget.themeProvider.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                  onPressed: () => widget.themeProvider.toggleTheme(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSection(String title, int count, {bool isCircle = false}) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 18,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
      SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: count,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => _playSong(music1[index]),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
              child: Container(
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: isCircle ? null : BorderRadius.circular(20),
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                ),
                child: Center(child: Text('Favorite Songs')),
              ),
            ),
          ),
        ),
      ),
    ];
  }
}

List<String> music1 = [
  'Music/song1.mp3',
  'Music/song2.mp3',
  'Music/song3.mp3',
  'Music/song4.mp3',
];
