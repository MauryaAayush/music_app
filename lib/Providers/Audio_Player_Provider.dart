import 'package:flutter/material.dart';
import 'package:music_app/model/searchable%20song.dart';


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

}