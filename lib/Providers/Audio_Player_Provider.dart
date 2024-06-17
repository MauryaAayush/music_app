import 'package:assets_audio_player/assets_audio_player.dart';
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
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  Stream<bool> get isPlaying => assetsAudioPlayer.isPlaying;

  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  int currentIndex = 0;

  void openSong(List<String> songList, int index) {
    currentIndex = index;
    assetsAudioPlayer.open(
      Audio(songList[currentIndex]),
      autoStart: true,
      showNotification: true,
    );

    assetsAudioPlayer.currentPosition.listen((duration) {
      currentPosition = duration;
      notifyListeners();
    });

    assetsAudioPlayer.current.listen((playingAudio) {
      totalDuration = playingAudio?.audio.duration ?? Duration.zero;
      notifyListeners();
    });
  }

  void playPause() {
    assetsAudioPlayer.playOrPause();
    notifyListeners();
  }

  void nextSong(List<String> songList) {
    if (currentIndex < songList.length - 1) {
      currentIndex++;
      assetsAudioPlayer.stop();
      openSong(songList, currentIndex);
      notifyListeners();
    }
  }

  void previousSong(List<String> songList) {
    if (currentIndex > 0) {
      currentIndex--;
      assetsAudioPlayer.stop();
      openSong(songList, currentIndex);
      notifyListeners();
    }
  }

  void seek(Duration position) {
    assetsAudioPlayer.seek(position);
    notifyListeners();
  }

  void dispose() {
    assetsAudioPlayer.dispose();
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return [
      if (hours > 0) hours,
      minutes,
      seconds,
    ].map(twoDigits).join(':');
  }






  // for API Work
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



