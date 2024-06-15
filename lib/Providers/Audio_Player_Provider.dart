import 'package:flutter/material.dart';
import 'package:music_app/model/searchable%20song.dart';


final List<String> recentSearches = [
  "fio",
  "is kadar tumse pyar ho gaya",
  "Dhanda Nyoliwala",
  "ve kamleya",
  "Mai saas leta hu",
  "Arijit Singh",
  "world war song",
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

class AudioPlayerProvider extends ChangeNotifier {

  // Future<void> _loadSongs() async {
  //   String playListJson =
  //   await rootBundle.loadString('assets/json/playlist.json');
  //   final parsed = jsonDecode(playListJson);
  //   final songList = parsed['songs'] as List<dynamic>;
  //   playlistSongs =
  //       songList.map((json) => PlaylistSong.fromJson(json)).toList();
  //
  //   notifyListeners();
  // }

  SongService _songService = SongService();
  List<Song> songs = [];
  bool _isLoading = false;

  bool get isLoading=>_isLoading;

  void searchSongs(String query) async {
    _isLoading = true;
    notifyListeners();
    try {
      List<Song> songs = await _songService.searchSongs(query);

      this.songs = songs;
      notifyListeners();
    } catch (e) {
      print('Error searching songs: $e');
      // Handle error
    }
    _isLoading = false;

    notifyListeners();
  }



  void removeRecentSearch(String search) {
    recentSearches.remove(search);
    notifyListeners();
  }

}