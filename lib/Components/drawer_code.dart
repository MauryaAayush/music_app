import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      width: 350,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
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
                text:  TextSpan(
                  text: 'MusicHole\n',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'version 2.0',
                      style: GoogleFonts.roboto(
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
                        ? 'assets/img/header-dark.jpg'
                        : 'assets/img/header.jpg',
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.teal,
                  ),
                  title: const Text(
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
           SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                const Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
                  child: Center(
                    child: Text(
                      'Made with ❤️ by Aayush Maurya',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}