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
  // final TextEditingController _searchController = TextEditingController();
  // bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Add a listener to the PageController to sync with TabController
    _pageController.addListener(() {
      if (_pageController.page!.round() != _tabController.index) {
        _tabController.animateTo(_pageController.page!.round());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pageProvider = Provider.of<PageProvider>(context);
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.transparent,
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: 230,
              // title: Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 60,
              //       width: 260,
              //
              //       decoration: BoxDecoration(
              //         color: Colors.blueGrey,
              //
              //       ),
              //       // child: TextField(
              //       //   // controller: _searchController,
              //       //   decoration: InputDecoration(
              //       //     contentPadding: EdgeInsets.zero,
              //       //     prefixIcon: Icon(Icons.search),
              //       //       border:OutlineInputBorder(
              //       //
              //       //       ),
              //       //       hintText: 'Songs, albums or artists',
              //       //       hintStyle: TextStyle(
              //       //         fontSize: 10
              //       //       )
              //       //   ),
              //       //   // onTap: () {
              //       //   //   setState(() {
              //       //   //     _isSearchFocused = true;
              //       //   //   });
              //       //   // },
              //       //   // onSubmitted: (value) {
              //       //   //   setState(() {
              //       //   //     _isSearchFocused = false;
              //       //   //   });
              //       //   // },
              //       // ),
              //     ),
              //   ],
              // ),
              flexibleSpace: FlexibleSpaceBar(
                // titlePadding: EdgeInsets.zero,
                // title: Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       height: 40,
                //       width: 260,
                //
                //       decoration: BoxDecoration(
                //         color: Colors.green,
                //
                //       ),
                //       // child: TextField(
                //       //   // controller: _searchController,
                //       //   decoration: InputDecoration(
                //       //     contentPadding: EdgeInsets.zero,
                //       //     prefixIcon: Icon(Icons.search),
                //       //       border:OutlineInputBorder(
                //       //
                //       //       ),
                //       //       hintText: 'Songs, albums or artists',
                //       //       hintStyle: TextStyle(
                //       //         fontSize: 10
                //       //       )
                //       //   ),
                //       //   // onTap: () {
                //       //   //   setState(() {
                //       //   //     _isSearchFocused = true;
                //       //   //   });
                //       //   // },
                //       //   // onSubmitted: (value) {
                //       //   //   setState(() {
                //       //   //     _isSearchFocused = false;
                //       //   //   });
                //       //   // },
                //       // ),
                //     ),
                //   ],
                // ),
                centerTitle: true,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Hi There,',
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              ),
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(Icons.horizontal_split),
              ),
              actions: [
                IconButton(
                  icon: Icon(themeProvider.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nights_stay),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ],
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              stretch: true,
              toolbarHeight: 55,
              title: Align(
                alignment: Alignment.centerRight,
                child: AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) {
                    return GestureDetector(
                      child: AnimatedContainer(
                        width: (!_scrollController.hasClients ||
                                _scrollController
                                        // ignore: invalid_use_of_protected_member
                                        .positions
                                        .length >
                                    1)
                            ? MediaQuery.of(context).size.width
                            : max(
                                MediaQuery.of(context).size.width -
                                    _scrollController.offset.roundToDouble(),
                                MediaQuery.of(context).size.width - 75,
                              ),
                        height: 52.0,
                        duration: const Duration(
                          milliseconds: 150,
                        ),
                        padding: const EdgeInsets.all(2.0),
                        // margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Theme.of(context).cardColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              offset: Offset(1.5, 1.5),
                              // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            Icon(
                              CupertinoIcons.search,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "hello",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // onTap: () => Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //     const SearchPage(
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
        
            // Main coding of
            SliverFillRemaining(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  pageProvider.setPage(index);
                  _tabController.animateTo(index);
                },
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          leading:
                              Image.network('https://via.placeholder.com/150'),
                          // Replace with song image
                          title: Text('Naino Ne Baandhi'),
                          subtitle: Text('Best Of Akshay Kumar'),
                          trailing: Icon(Icons.more_vert),
                        ),
                        ListTile(
                          leading:
                              Image.network('https://via.placeholder.com/150'),
                          // Replace with song image
                          title: Text('Jogi - Lyrical |Shaadi M...'),
                          subtitle: Text('Shafqat Amanat Ali'),
                          trailing: Icon(Icons.more_vert),
                        ),
                        ListTile(
                          leading:
                              Image.network('https://via.placeholder.com/150'),
                          // Replace with song image
                          title: Text('World War (Lofi) (Lo...'),
                          subtitle: Text('Saaaj Tomar, chaahat,...'),
                          trailing: Icon(Icons.play_arrow),
                        ),
                      ],
                    ),
                  ),
                  // Container(color: Colors.blue),
                  Container(color: Colors.red),
                  Container(color: Colors.greenAccent.shade700),
                  Container(color: Colors.orange),
                ],
              ),
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
