import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:bottom_bar/bottom_bar.dart';
import '../Components/drawer_code.dart';
import '../Providers/theme_provider.dart';
import '../Providers/page_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  double _containerWidth = 380;
  // final TextEditingController _searchController = TextEditingController();
  // bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_scrollListener);
    // Add a listener to the PageController to sync with TabController
    _pageController.addListener(() {
      if (_pageController.page!.round() != _tabController.index) {
        _tabController.animateTo(_pageController.page!.round());
      }
    });
  }
  void _scrollListener() {
    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      setState(() {
        if (offset > 90) {
          _containerWidth = 300;
        } else {
          _containerWidth = 380;
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    pageProvider.setPage(index);
                    _tabController.animateTo(index);
                  },
                  children: [
                    Stack(
                      children: [
                        NestedScrollView(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          headerSliverBuilder: (context, innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                toolbarHeight: 65,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                expandedHeight: 185,
                                flexibleSpace: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return FlexibleSpaceBar(
                                      background: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [

                                          SizedBox(
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              'Hi There,',
                                              style: TextStyle(
                                                fontSize: 29,
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              'Aayush',
                                              style: TextStyle(
                                                fontSize: 22,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                pinned: true,
                                backgroundColor: Colors.transparent,
                                forceMaterialTransparency: true,
                                elevation: 0,
                                stretch: true,
                                toolbarHeight: 65,
                                title: Align(
                                  alignment: Alignment.center,
                                  child: AnimatedBuilder(
                                    animation: _scrollController,
                                    builder: (context, child) {
                                      return GestureDetector(
                                        child: AnimatedContainer(
                                          width:_containerWidth,
                                          height: 62.0,
                                          duration:
                                              const Duration(milliseconds: 150),
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Theme.of(context).cardColor,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 5.0,
                                                offset: Offset(1.5, 1.5),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 10.0),
                                              Icon(
                                                CupertinoIcons.search,
                                                color: Colors.teal,
                                              ),
                                              const SizedBox(width: 10.0),
                                              Text(
                                                "Songs, albums or artists",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Uncomment the following code if you want to navigate to a search page
                                        // onTap: () => Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => SearchPage(
                                        //       query: '',
                                        //       fromHome: true,
                                        //       autofocus: true,
                                        //     ),
                                        //   ),
                                        // ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ];
                          },
                          body: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Your Playlists',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      Icon(Icons.chevron_right)
                                    ],
                                  ),
                                ),
                                // Add Playlist Widget here
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Container(
                                    height: 100,
                                    color: Colors.blue,
                                    // Replace with your playlist widget
                                    child: Center(child: Text('Favorite Songs')),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Text(
                                    'Last Session',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                                // Add Last Session Widgets here
                                ListTile(
                                  leading: Image.network(
                                      'https://via.placeholder.com/150'),
                                  // Replace with song image
                                  title: Text('Naino Ne Baandhi'),
                                  subtitle: Text('Best Of Akshay Kumar'),
                                  trailing: Icon(Icons.more_vert),
                                ),
                                ListTile(
                                  leading: Image.network(
                                      'https://via.placeholder.com/150'),
                                  // Replace with song image
                                  title: Text('Jogi - Lyrical |Shaadi M...'),
                                  subtitle: Text('Shafqat Amanat Ali'),
                                  trailing: Icon(Icons.more_vert),
                                ),
                                ListTile(
                                  leading: Image.network(
                                      'https://via.placeholder.com/150'),
                                  // Replace with song image
                                  title: Text('World War (Lofi) (Lo...'),
                                  subtitle: Text('Saaaj Tomar, chaahat,...'),
                                  trailing: Icon(Icons.play_arrow),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 4.0, right: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onPressed: () => themeProvider.toggleTheme(),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),

                    // Other Screens
                    Container(color: Colors.red),
                    Container(color: Colors.greenAccent.shade700),
                    Container(color: Colors.orange),
                  ]),
            ),
          ],
        ),
      ),

      // Bottom Navigation bar
      bottomNavigationBar: BottomBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        selectedIndex: pageProvider.currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          pageProvider.setPage(index);
          _tabController
              .animateTo(index); // Sync TabBar with BottomNavigationBar
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(
              Icons.home,
              size: 27,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            activeColor: Colors.tealAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(Icons.trending_up),
            title: Text(
              'Top Charts',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            activeColor: Colors.tealAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(MdiIcons.youtube),
            title: Text(
              'Youtube',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            activeColor: Colors.tealAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(Icons.library_music_rounded),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            activeColor: Colors.tealAccent.shade700,
          ),
        ],
      ),
    );
  }
}
