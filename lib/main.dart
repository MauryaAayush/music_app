import 'package:flutter/material.dart';
import 'package:music_app/Providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider(),)
    ],
        child : const MusicApp()
    ),
  );
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const HomeScreen(),
    );
  }
}




class HomeScreen extends  StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return  Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(onPressed: () {
            setState(() {
              _scaffoldKey.currentState?.openDrawer();
            });
          }, icon:  Icon(Icons.horizontal_split_rounded,),
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text('Music'),
          actions: [
            Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
        drawer:  Drawer(
        width: 350,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                // backgroundColor: Colors.transparent,
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('MusicHole'),
                  background: Image.asset(
                    'assets/header.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
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
                      leading: const Icon(Icons.folder),
                      title: const Text('Playlists'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
