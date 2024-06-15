import 'package:flutter/material.dart';
import 'package:music_app/Providers/Audio_Player_Provider.dart';
import 'package:provider/provider.dart';

import '../Providers/theme_provider.dart';
import '../model/searchable song.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> recentSearches = [
    "is kadar tumse pyar ho gaya",
    "ve kamleya",
    "Mai saas leta hu",
    "Arijit Singh",
    "thar",
    "gangster paradise"
  ];
  final List<String> trendingSearches = [
    "Sajni",
    "Arijit Singh",
    "Bhakti Songs",
    "Namo Namo",
    "Amit Saini Rohtakiya",
    "Lofar"
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<  ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onSubmitted: (value) {
            Provider.of<AudioPlayerProvider>(context, listen: false)
                .searchSongs(value);

            if (value.isNotEmpty) {
              setState(() {
                recentSearches.add(value);
                _searchController
                    .clear(); // Clear the text field after submission
              });
            }
          },
          decoration: InputDecoration(
            hintText: 'Songs, albums or artists',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeProvider.isDarkMode
                  ? [Colors.grey.shade900, Colors.black]
                  : [const Color(0xfff5f9ff), Colors.white],
              // Light mode gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),


        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<AudioPlayerProvider>(
                    builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  // Check if songs are empty
                  if (provider.songs.isEmpty) {
                    return Center(
                      child: Text('No songs found'),
                    );
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          Provider.of<AudioPlayerProvider>(context, listen: true)
                              .songs
                              .length,
                      itemBuilder: (context, index) {
                        Song song = Provider.of<AudioPlayerProvider>(context,
                                listen: true)
                            .songs[index];
                        return ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(song.image)),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          title: Text(song.song, style: TextStyle(fontSize: 20)),
                          subtitle: Text(
                            song.singers,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      });
                }),

                  Wrap(
                    spacing: 8.0,
                    children: recentSearches.map((search) {
                      return Chip(
                        label: Text(search),
                        deleteIcon: Icon(Icons.cancel),
                        onDeleted: () {
                          setState(() {
                            recentSearches.remove(search);
                          });
                        },
                      );
                    }).toList(),
                  ),
                SizedBox(height: 16.0),
                Text(
                  'Trending Search',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                // Show trending searches only if not searching
                  Wrap(
                    spacing: 8.0,
                    children: trendingSearches.map((search) {
                      return Chip(
                        label: Text(search),
                      );
                    }).toList(),
                  ),
                // Show search results if searching

              ],
            ),
          ),
        ),
      ),
    );
  }
}
