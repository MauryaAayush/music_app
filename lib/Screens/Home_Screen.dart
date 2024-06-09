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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  late TabController _tabController;
  bool _isSearchBarVisible = true;

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

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerScreen(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Songs, albums or artists',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Hi There, Aayush',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.horizontal_split),
            ),

            actions: [
              IconButton(
                icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Your Playlists',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
                // Add Playlist Widget here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    height: 100,
                    color: Colors.grey[300], // Replace with your playlist widget
                    child: Center(child: Text('Favorite Songs')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  leading: Image.network('https://via.placeholder.com/150'), // Replace with song image
                  title: Text('Naino Ne Baandhi'),
                  subtitle: Text('Best Of Akshay Kumar'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: Image.network('https://via.placeholder.com/150'), // Replace with song image
                  title: Text('Jogi - Lyrical |Shaadi M...'),
                  subtitle: Text('Shafqat Amanat Ali'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: Image.network('https://via.placeholder.com/150'), // Replace with song image
                  title: Text('World War (Lofi) (Lo...'),
                  subtitle: Text('Saaaj Tomar, chaahat,...'),
                  trailing: Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //       return ListTile(
          //         title: Text('Item #$index'),
          //       );
          //     },
          //     childCount: 100,
          //   ),
          // ),

          SliverFillRemaining(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                pageProvider.setPage(index);
                _tabController.animateTo(index);
              },
              children: [
                Container(color: Colors.blue),
                Container(color: Colors.red),
                Container(color: Colors.greenAccent.shade700),
                Container(color: Colors.orange),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        selectedIndex: pageProvider.currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          pageProvider.setPage(index);
          _tabController.animateTo(index);  // Sync TabBar with BottomNavigationBar
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home, size: 27,),
            title: Text('Home', style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17
            ),),
            activeColor: Colors.tealAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Top Charts', style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600
            ),
            ),
            activeColor: Colors.tealAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(MdiIcons.youtube),
            title: Text('Youtube', style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600
            ),),
            activeColor: Colors.tealAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(Icons.library_music_rounded),
            title: Text('Settings', style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600
            ),),
            activeColor: Colors.tealAccent.shade700,
          ),
        ],
      ),
    );
  }
}
