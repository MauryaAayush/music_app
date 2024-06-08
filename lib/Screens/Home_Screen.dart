import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/drawer_code.dart';
import '../Providers/theme_provider.dart';
import '../Providers/page_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _scaffoldKey.currentState?.openDrawer();
            });
          },
          icon: Icon(
            Icons.horizontal_split_rounded,
          ),
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text('Music'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: PageView(
        controller: _pageController,
        children: [
          Container(color: Colors.blue),
          Container(color: Colors.red),
          Container(color: Colors.greenAccent.shade700),
          Container(color: Colors.orange),
        ],
        onPageChanged: (index) {
          pageProvider.setPage(index);
        },
      ),
      bottomNavigationBar: Consumer<PageProvider>(
        builder: (context, pageProvider, child) {
          return BottomBar(
            backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
            selectedIndex: pageProvider.currentPage,
            onTap: (int index) {
              _pageController.jumpToPage(index);
              pageProvider.setPage(index);
            },
            items: <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.home,size: 27,),
                title: Text('Home',style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17
                ),),
                activeColor: Colors.tealAccent.shade700,
              ),
              BottomBarItem(
                icon: Icon(Icons.trending_up),
                title: Text('Favorites'),
                activeColor: Colors.tealAccent.shade700,
              ),
              BottomBarItem(
                icon: Icon(Icons.person),
                title: Text('Account'),
                activeColor: Colors.tealAccent.shade700,
              ),
              BottomBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: Colors.tealAccent.shade700,
              ),
            ],
          );
        },
      ),
    );
  }
}


