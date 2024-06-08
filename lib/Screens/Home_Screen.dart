import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      drawer: Drawer(
        width: 350,
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: false,
          slivers: [
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              stretch: false,
              elevation: 0,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: RichText(
                  text: TextSpan(
                    text: 'Music Hole\n',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'version 2.0',
                        style: const TextStyle(
                          fontSize: 7.0,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.end,
                ),
                titlePadding: const EdgeInsets.only(bottom: 40.0),
                background: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.1),
                      ],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: AssetImage(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/header-dark.jpg'
                          : 'assets/header.jpg',
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.folder),
                    title: const Text('My Music'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.download_done_sharp),
                    title: const Text('Download'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.playlist_play),
                    title: const Text('Playlists'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
                    child: Center(
                      child: Text(
                        'Made with ❤️ by Aayush Maurya',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
            selectedIndex: pageProvider.currentPage,
            onTap: (int index) {
              _pageController.jumpToPage(index);
              pageProvider.setPage(index);
            },
            items: <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.blue,
              ),
              BottomBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favorites'),
                activeColor: Colors.red,
              ),
              BottomBarItem(
                icon: Icon(Icons.person),
                title: Text('Account'),
                activeColor: Colors.greenAccent.shade700,
              ),
              BottomBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: Colors.orange,
              ),
            ],
          );
        },
      ),
    );
  }
}
