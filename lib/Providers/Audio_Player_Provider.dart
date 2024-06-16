import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  int _currentIndex = 0;
  late List<String> musicList;

  AudioPlayerProvider() {
    _audioPlayer = AudioPlayer();
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(musicList[_currentIndex])));
    _audioPlayer.playbackEventStream.listen((event) {
      _isPlaying = event.processingState == ProcessingState.loading;
      notifyListeners();
    });
  }


  bool get isPlaying => _isPlaying;
  int get currentIndex => _currentIndex;

  void setMusicList(List<String> list) {
    musicList = list;
    _initializeAudioPlayer();
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void changeTrack(int index) {
    _currentIndex = index;
    _initializeAudioPlayer();
  }


  //
  // late AudioPlayer _audioPlayer;
  // bool _isPlaying = false;
  // int _currentIndex = 0;
  //
  //
  // Future<void> playMusic(String musicPath) async {
  //   await _audioPlayer.setFilePath(musicPath);
  //   await _audioPlayer.play();
  //   notifyListeners();
  // }
  //
  // Future<void> pauseMusic() async {
  //   await _audioPlayer.pause();
  //   notifyListeners();
  // }
  //
  // Future<void> stopMusic() async {
  //   await _audioPlayer.stop();
  //   notifyListeners();
  // }
  //
  // bool get isPlaying => _audioPlayer.playing;
  //
  // @override
  // void dispose() {
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }


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



