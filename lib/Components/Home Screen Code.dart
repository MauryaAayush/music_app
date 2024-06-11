import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Providers/theme_provider.dart';
import 'SliverAppBarForGeading.dart';
import 'SliverAppBarForSearch.dart';

class HomeScreenCode extends StatelessWidget {
  const HomeScreenCode({
    super.key,
    required ScrollController scrollController,
    required double containerWidth,
    required this.themeProvider,
  }) : _scrollController = scrollController, _containerWidth = containerWidth;

  final ScrollController _scrollController;
  final double _containerWidth;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
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
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                // Add Playlist Widget here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    height: 170,
                    width: 170,

                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    // Replace with your playlist widget
                    child: Center(child: Text('Favorite Songs')),
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
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                // Add Last Session Widgets here

                CarouselSlider(items: [
                  Column(
                    children: [
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('Naino Ne Baandhi'),
                        subtitle: Text('Best Of Akshay Kumar'),
                        trailing: Icon(Icons.more_vert),
                      ),
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('Jogi - Lyrical |Shaadi M...'),
                        subtitle: Text('Shafqat Amanat Ali'),
                        trailing: Icon(Icons.more_vert),
                      ),
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('World War (Lofi) (Lo...'),
                        subtitle: Text('Saaaj Tomar, chaahat,...'),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('Naino Ne Baandhi'),
                        subtitle: Text('Best Of Akshay Kumar'),
                        trailing: Icon(Icons.more_vert),
                      ),
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('Jogi - Lyrical |Shaadi M...'),
                        subtitle: Text('Shafqat Amanat Ali'),
                        trailing: Icon(Icons.more_vert),
                      ),
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('World War (Lofi) (Lo...'),
                        subtitle: Text('Saaaj Tomar, chaahat,...'),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('Naino Ne Baandhi'),
                        subtitle: Text('Best Of Akshay Kumar'),
                        trailing: Icon(Icons.more_vert),
                      ),
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('Jogi - Lyrical |Shaadi M...'),
                        subtitle: Text('Shafqat Amanat Ali'),
                        trailing: Icon(Icons.more_vert),
                      ),
                      ListTile(
                        leading: Image.network('https://via.placeholder.com/150'),
                        // Replace with song image
                        title: Text('World War (Lofi) (Lo...'),
                        subtitle: Text('Saaaj Tomar, chaahat,...'),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ], options: CarouselOptions(
                  height: 410,
                  padEnds: false,
                  viewportFraction:
                  0.85, // Adjust this value for visibility from the right
                  enableInfiniteScroll: false,
                  autoPlay: false,
                )),



              ],
            ),
          ),
        ),
        Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(
                top: 8.0, left: 4.0, right: 4.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Transform.rotate(
                  angle: 22 / 7 * 2,
                  child: IconButton(
                    icon: const Icon(
                        Icons.horizontal_split_rounded),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context)
                        .openAppDrawerTooltip,
                  ),
                ),
                IconButton(
                  icon: Icon(themeProvider.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                  onPressed: () =>
                      themeProvider.toggleTheme(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}