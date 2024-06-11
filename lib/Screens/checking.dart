import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ThemeProvider themeProvider = ThemeProvider();
  final PageProvider pageProvider = PageProvider();
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 65,
              backgroundColor: Colors.transparent,
              floating: true,
              expandedHeight: 135,
              flexibleSpace: FlexibleSpaceBar(
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
                            _scrollController.positions.length > 1)
                            ? MediaQuery.of(context).size.width
                            : max(
                          MediaQuery.of(context).size.width -
                              _scrollController.offset.roundToDouble(),
                          MediaQuery.of(context).size.width - 75,
                        ),
                        height: 52.0,
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
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
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 10.0),
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
        body: Container(color: Colors.blue),
      ),
      bottomNavigationBar: BottomBar(
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

class ThemeProvider {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
  }
}

class PageProvider {
  int currentPage = 0;

  void setPage(int index) {
    currentPage = index;
  }
}

class BottomBar extends StatelessWidget {
  final Color backgroundColor;
  final int selectedIndex;
  final Function(int) onTap;
  final List<BottomBarItem> items;

  BottomBar({
    required this.backgroundColor,
    required this.selectedIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      currentIndex: selectedIndex,
      onTap: onTap,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: item.icon,
          label: item.title.data,
          backgroundColor: item.activeColor,
        );
      }).toList(),
    );
  }
}

class BottomBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;

  BottomBarItem({
    required this.icon,
    required this.title,
    required this.activeColor,
  });
}
