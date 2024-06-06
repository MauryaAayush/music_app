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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}




class HomeScreen extends  StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(onPressed: () {
            setState(() {
              Scaffold.of(context).openDrawer();
            });
          }, icon:  Icon(Icons.horizontal_split_rounded,),
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text('Music'),
        ),
        drawer:  Drawer(

        )
    );
  }
}
