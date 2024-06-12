import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:bottom_bar/bottom_bar.dart';
import '../Components/Home Screen Code.dart';
import '../Components/MiniPlayer.dart';
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
          _containerWidth = MediaQuery.of(context).size.width * 0.7;
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
              Expanded(
                child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      pageProvider.setPage(index);
                      _tabController.animateTo(index);
                    },
                    children: [
                      // Home Screen
                      HomeScreenCode(scrollController: _scrollController, containerWidth: _containerWidth, themeProvider: themeProvider),

                      // Other Screens
                      Container(color: Colors.red),
                      Container(color: Colors.greenAccent.shade700),
                      Container(color: Colors.orange),
                    ]),
              ),
              MiniPlayer(), // Add MiniPlayer here
            ],
          ),
        ),
      ),

      // Bottom Navigation bar
      bottomNavigationBar: BottomNavigationBar(
        themeProvider: themeProvider,
        pageProvider: pageProvider,
        pageController: _pageController,
        tabController: _tabController,
      ),
    );
  }
}



class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
    required this.themeProvider,
    required this.pageProvider,
    required PageController pageController,
    required TabController tabController,
  })  : _pageController = pageController,
        _tabController = tabController;

  final ThemeProvider themeProvider;
  final PageProvider pageProvider;
  final PageController _pageController;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      selectedIndex: pageProvider.currentPage,
      onTap: (int index) {
        _pageController.jumpToPage(index);
        pageProvider.setPage(index);
        _tabController.animateTo(index); // Sync TabBar with BottomNavigationBar
      },
      items: <BottomBarItem>[
        BottomBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Text(
            'Home',
          ),
          activeColor: Colors.tealAccent,
        ),
        BottomBarItem(
          icon: Icon(Icons.trending_up),
          title: Text(
            'Top Charts',
          ),
          activeColor: Colors.tealAccent,
        ),
        BottomBarItem(
          icon: Icon(MdiIcons.youtube),
          title: Text(
            'Youtube',
          ),
          activeColor: Colors.tealAccent,
        ),
        BottomBarItem(
          icon: Icon(Icons.library_music_rounded),
          title: Text(
            'Settings',
          ),
          activeColor: Colors.tealAccent,
        ),
      ],
    );
  }
}
