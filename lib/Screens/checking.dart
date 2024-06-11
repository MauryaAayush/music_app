// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'dart:math';
//
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// class MyHomePage extends StatelessWidget {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final ScrollController _scrollController = ScrollController();
//   final PageController _pageController = PageController();
//   final ThemeProvider themeProvider = ThemeProvider();
//   final PageProvider pageProvider = PageProvider();
//   late TabController _tabController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: NestedScrollView(
//         controller: _scrollController,
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return <Widget>[
//             SliverAppBar(
//               toolbarHeight: 65,
//               backgroundColor: Colors.transparent,
//               floating: true,
//               expandedHeight: 135,
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: true,
//                 background: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         'Hi There,',
//                         style: TextStyle(
//                           fontSize: 30,
//                           letterSpacing: 1.5,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.teal,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Text(
//                         'Aayush',
//                         style: TextStyle(
//                           fontSize: 22,
//                           letterSpacing: 1,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               leading: IconButton(
//                 onPressed: () {
//                   _scaffoldKey.currentState?.openDrawer();
//                 },
//                 icon: Icon(Icons.horizontal_split),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(themeProvider.isDarkMode
//                       ? Icons.wb_sunny
//                       : Icons.nights_stay),
//                   onPressed: () => themeProvider.toggleTheme(),
//                 ),
//               ],
//             ),
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               pinned: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               stretch: true,
//               toolbarHeight: 55,
//               title: Align(
//                 alignment: Alignment.centerRight,
//                 child: AnimatedBuilder(
//                   animation: _scrollController,
//                   builder: (context, child) {
//                     return GestureDetector(
//                       child: AnimatedContainer(
//                         width: (!_scrollController.hasClients ||
//                             _scrollController.positions.length > 1)
//                             ? MediaQuery.of(context).size.width
//                             : max(
//                           MediaQuery.of(context).size.width -
//                               _scrollController.offset.roundToDouble(),
//                           MediaQuery.of(context).size.width - 75,
//                         ),
//                         height: 52.0,
//                         duration: const Duration(milliseconds: 150),
//                         padding: const EdgeInsets.all(2.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           color: Theme.of(context).cardColor,
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 5.0,
//                               offset: Offset(1.5, 1.5),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             const SizedBox(width: 10.0),
//                             Icon(
//                               CupertinoIcons.search,
//                               color: Theme.of(context).colorScheme.secondary,
//                             ),
//                             const SizedBox(width: 10.0),
//                             Text(
//                               "hello",
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Uncomment the following code if you want to navigate to a search page
//                       // onTap: () => Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => SearchPage(
//                       //       query: '',
//                       //       fromHome: true,
//                       //       autofocus: true,
//                       //     ),
//                       //   ),
//                       // ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ];
//         },
//         body: Container(color: Colors.blue),
//       ),
//       bottomNavigationBar: BottomBar(
//         backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
//         selectedIndex: pageProvider.currentPage,
//         onTap: (int index) {
//           _pageController.jumpToPage(index);
//           pageProvider.setPage(index);
//           _tabController.animateTo(index); // Sync TabBar with BottomNavigationBar
//         },
//         items: <BottomBarItem>[
//           BottomBarItem(
//             icon: Icon(
//               Icons.home,
//               size: 27,
//             ),
//             title: Text(
//               'Home',
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
//             ),
//             activeColor: Colors.tealAccent.shade700,
//           ),
//           BottomBarItem(
//             icon: Icon(Icons.trending_up),
//             title: Text(
//               'Top Charts',
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//             ),
//             activeColor: Colors.tealAccent.shade700,
//           ),
//           BottomBarItem(
//             icon: Icon(MdiIcons.youtube),
//             title: Text(
//               'Youtube',
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//             ),
//             activeColor: Colors.tealAccent.shade700,
//           ),
//           BottomBarItem(
//             icon: Icon(Icons.library_music_rounded),
//             title: Text(
//               'Settings',
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//             ),
//             activeColor: Colors.tealAccent.shade700,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ThemeProvider {
//   bool isDarkMode = false;
//
//   void toggleTheme() {
//     isDarkMode = !isDarkMode;
//   }
// }
//
// class PageProvider {
//   int currentPage = 0;
//
//   void setPage(int index) {
//     currentPage = index;
//   }
// }
//
// class BottomBar extends StatelessWidget {
//   final Color backgroundColor;
//   final int selectedIndex;
//   final Function(int) onTap;
//   final List<BottomBarItem> items;
//
//   BottomBar({
//     required this.backgroundColor,
//     required this.selectedIndex,
//     required this.onTap,
//     required this.items,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: backgroundColor,
//       currentIndex: selectedIndex,
//       onTap: onTap,
//       items: items.map((item) {
//         return BottomNavigationBarItem(
//           icon: item.icon,
//           label: item.title.data,
//           backgroundColor: item.activeColor,
//         );
//       }).toList(),
//     );
//   }
// }
//
// class BottomBarItem {
//   final Icon icon;
//   final Text title;
//   final Color activeColor;
//
//   BottomBarItem({
//     required this.icon,
//     required this.title,
//     required this.activeColor,
//   });
// }
import 'dart:io';

import 'package:flutter/material.dart';

import '../All Gradients/Gradient Conatiners.dart';



// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({super.key});
//
//   @override
//   _MiniPlayerState createState() => _MiniPlayerState();
// }
//
// class _MiniPlayerState extends State<MiniPlayer> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final bool rotated = MediaQuery.of(context).size.height < screenWidth;
//     final bool useDense = false || rotated; // Simplified for example
//     final List preferredMiniButtons = ['Like', 'Play/Pause', 'Next']; // Simplified for example
//
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
//         child: SizedBox(
//           height: useDense ? 68.0 : 76.0,
//           child: GradientContainer(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ListTile(
//                   dense: useDense,
//                   onTap: () {
//                     Navigator.of(context).push(
//                       PageRouteBuilder(
//                         opaque: false,
//                         pageBuilder: (_, __, ___) => const PlayScreen(
//                           songsList: [],
//                           index: 1,
//                           offline: null,
//                           fromMiniplayer: true,
//                           fromDownloads: false,
//                           recommend: false,
//                         ),
//                       ),
//                     );
//                   },
//                   title: const Text(
//                     'Song Title', // Placeholder
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   subtitle: const Text(
//                     'Artist Name', // Placeholder
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   leading: Hero(
//                     tag: 'currentArtwork',
//                     child: Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(7.0),
//                       ),
//                       clipBehavior: Clip.antiAlias,
//                       child: SizedBox.square(
//                         dimension: useDense ? 40.0 : 50.0,
//                         child: CachedNetworkImage(
//                           fit: BoxFit.cover,
//                           errorWidget: (BuildContext context, _, __) =>
//                           const Image(
//                             fit: BoxFit.cover,
//                             image: AssetImage('assets/cover.jpg'),
//                           ),
//                           placeholder: (BuildContext context, _) =>
//                           const Image(
//                             fit: BoxFit.cover,
//                             image: AssetImage('assets/cover.jpg'),
//                           ),
//                           imageUrl: 'https://via.placeholder.com/150', // Placeholder
//                         ),
//                       ),
//                     ),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: preferredMiniButtons.map((button) {
//                       return IconButton(
//                         icon: Icon(
//                           button == 'Play/Pause'
//                               ? Icons.play_arrow
//                               : button == 'Next'
//                               ? Icons.skip_next
//                               : Icons.favorite_border,
//                         ),
//                         onPressed: () {},
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SliderTheme(
//                   data: SliderTheme.of(context).copyWith(
//                     activeTrackColor: Theme.of(context).colorScheme.secondary,
//                     inactiveTrackColor: Colors.transparent,
//                     trackHeight: 0.5,
//                     thumbColor: Theme.of(context).colorScheme.secondary,
//                     thumbShape: const RoundSliderThumbShape(
//                       enabledThumbRadius: 1.0,
//                     ),
//                     overlayColor: Colors.transparent,
//                     overlayShape: const RoundSliderOverlayShape(
//                       overlayRadius: 2.0,
//                     ),
//                   ),
//                   child: Center(
//                     child: Slider(
//                       inactiveColor: Colors.transparent,
//                       value: 0.0, // Placeholder
//                       max: 100.0, // Placeholder
//                       onChanged: (newPosition) {},
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
