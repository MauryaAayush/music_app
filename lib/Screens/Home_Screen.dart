import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              icon: Icon(themeProvider.isDarkMode
                  ? Icons.wb_sunny
                  : Icons.nights_stay),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ],
        ),
        drawer: Drawer(
          width: 350,
          // child: Column(
          //   children: [
          //     Container(
          //       height: 300,
          //       width: 350,
          //       decoration: BoxDecoration(
          //     image: DecorationImage(image: AssetImage('assets/header.jpg'),fit: BoxFit.cover)
          //       ),
          //     )
          //   ],
          // ),
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
                      leading:  Icon(Icons.home,color: Colors.teal,),
                      title:  Text('Home',style: TextStyle(
                        color: Colors.teal,
                      ),),
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
                        child: Text( 'Made with ❤️ by Aayush Maurya',
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
        ));
  }
}