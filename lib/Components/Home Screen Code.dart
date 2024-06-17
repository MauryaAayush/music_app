import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Providers/Audio_Player_Provider.dart';
import '../Providers/theme_provider.dart';
import '../Screens/PlayScreen.dart';
import '../model/Image_List.dart';
import 'SliverAppBarForGeading.dart';
import 'SliverAppBarForSearch.dart';
import 'carousal_Column.dart';

class HomeScreenCode extends StatelessWidget {
  HomeScreenCode({
    super.key,
    required ScrollController scrollController,
    required double containerWidth,
    required this.themeProvider,
  })  : _scrollController = scrollController,
        _containerWidth = containerWidth;

  final ScrollController _scrollController;
  final double _containerWidth;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    final musicPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    final musicProviderfalse = Provider.of<MusicProvider>(context,listen: false);

    return Stack(
      children: [
        NestedScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              const SliverForGreading(),
              SliverForSearch(
                  scrollController: _scrollController,
                  containerWidth: _containerWidth),
            ];
          },
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // Heading of type of songs
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                // Add Playlist Widget here
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: CarouselSlider.builder(
                      itemCount: musicProviderfalse.mainList.length,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(musicProviderfalse.mainList[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Text(musicProviderfalse.mainList[index]['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioPlayerScreen(
                                 initialIndex: index,
                                  songList: musicProviderfalse.mainList,
                                ),
                              ),
                            );
                            musicProviderfalse.openSong(musicProviderfalse.mainList,index);
                            // Navigator.of(context).pushNamed('/play');

                          },
                        );
                      },
                      options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                // Add Last Session Widgets here

                CarouselSlider(
                    items: const [
                      Carousal_Column(),
                      Carousal_Column(),
                      Carousal_Column(),
                      Carousal_Column(),
                    ],
                    options: CarouselOptions(
                      height: 340,
                      padEnds: false,
                      viewportFraction: 0.85,
                      // Adjust this value for visibility from the right
                      enableInfiniteScroll: false,
                      autoPlay: false,
                    )),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending Now',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 8.0, bottom: 8),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('assets/trending.jpg'), // Replace 'your_image.jpg' with your image path
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                        ),
                        child: Center(
                          child: Text('Favorite Songs'),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Charts',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 8.0, bottom: 8),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage('assets/trend.jpg'), // Replace 'your_image.jpg' with your image path
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                        ),
                        child: Center(
                          child: Text('Favorite Songs'),
                        ),
                      ),

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Released',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 8.0, bottom: 8),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        // Replace with your playlist widget
                        child: Center(child: Text('Favorite Songs')),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Radio Stations',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 8.0, bottom: 8),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        // Replace with your playlist widget
                        child: Center(child: Text('Favorite Songs')),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended Artist',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(imagePaths[index]),fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Devotional',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 8.0, bottom: 8),
                      child: Container(
                        width: 170,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        // Replace with your playlist widget
                        child: Center(child: Text('Favorite Songs')),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Songs',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                        ),
                      ),
                      Icon(Icons.chevron_right),
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
                      height: 340,
                      padEnds: false,
                      viewportFraction: 0.85,
                      // Adjust this value for visibility from the right
                      enableInfiniteScroll: false,
                      autoPlay: false,
                    )),
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
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
                IconButton(
                  icon: Icon(themeProvider.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
