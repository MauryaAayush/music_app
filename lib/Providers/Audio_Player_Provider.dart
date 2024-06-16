// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:music_app/model/searchable%20song.dart';
//
//
// final List<String> recentSearches = [
//   "fio",
//   "is kadar tumse pyar ho gaya",
//   "Dhanda Nyoliwala",
//   "ve kamleya",
//   "Mai saas leta hu",
//   "Arijit Singh",
//   "world war song",
//   "thar",
//   "gangster paradise"
// ];
// final List<String> trendingSearches = [
//   "Sajni",
//   "Arijit Singh",
//   "Bhakti Songs",
//   "Namo Namo",
//   "Amit Saini Rohtakiya",
//   "Lofar"
// ];
//
// class AudioPlayerProvider extends ChangeNotifier {
//
//
//   List musicList = [
//     'assets/Music/song1.mp3',
//     'assets/Music/song2.mp3',
//     'assets/Music/song3.mp3',
//     'assets/Music/song4.mp3',
//     'assets/Music/song5.mp3',
//     'assets/Music/song6.mp3',
//     'assets/Music/song7.mp3',
//     'assets/Music/song8.mp3',
//     'assets/Music/song9.mp3',
//     'assets/Music/song10.mp3',
//     'assets/Music/song11.mp3',
//     'assets/Music/song12.mp3',
//     'assets/Music/song13.mp3',
//     'assets/Music/song14.mp3',
//     'assets/Music/song15.mp3',
//     'assets/Music/song16.mp3',
//     'assets/Music/song17.mp3',
//     'assets/Music/song18.mp3',
//   ];
//
//   late AudioPlayer _audioPlayer;
//   bool _isPlaying = false;
//   int _currentIndex = 0;
//
//   AudioPlayerProvider() {
//     _audioPlayer = AudioPlayer();
//     _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(musicList[_currentIndex])));
//     _audioPlayer.playbackEventStream.listen((event) {
//       _isPlaying = event.state == PlayerState.playing;
//       notifyListeners();
//     });
//   }
//
//   bool get isPlaying => _isPlaying;
//   int get currentIndex => _currentIndex;
//
//   void play() {
//     _audioPlayer.play();
//   }
//
//   void pause() {
//     _audioPlayer.pause();
//   }
//
//   void stop() {
//     _audioPlayer.stop();
//   }
//
//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//   }
//
//   void changeTrack(int index) {
//     _currentIndex = index;
//     _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(musicList[_currentIndex])));
//     _audioPlayer.play();
//   }
//
//
//
//
//   // Future<void> _loadSongs() async {
//   //   String playListJson =
//   //   await rootBundle.loadString('assets/json/playlist.json');
//   //   final parsed = jsonDecode(playListJson);
//   //   final songList = parsed['songs'] as List<dynamic>;
//   //   playlistSongs =
//   //       songList.map((json) => PlaylistSong.fromJson(json)).toList();
//   //
//   //   notifyListeners();
//   // }
//
//   SongService _songService = SongService();
//   List<Song> songs = [];
//   bool _isLoading = false;
//
//   bool get isLoading=>_isLoading;
//
//   void searchSongs(String query) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       List<Song> songs = await _songService.searchSongs(query);
//
//       this.songs = songs;
//       notifyListeners();
//     } catch (e) {
//       print('Error searching songs: $e');
//       // Handle error
//     }
//     _isLoading = false;
//
//     notifyListeners();
//   }
//
//
//
//   void removeRecentSearch(String search) {
//     recentSearches.remove(search);
//     notifyListeners();
//   }
//
// }



import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List musicList = [
    'assets/Music/song1.mp3',
    'assets/Music/song2.mp3',
    'assets/Music/song3.mp3',
    'assets/Music/song4.mp3',
    'assets/Music/song5.mp3',
    'assets/Music/song6.mp3',
    'assets/Music/song7.mp3',
    'assets/Music/song8.mp3',
    'assets/Music/song9.mp3',
    'assets/Music/song10.mp3',
    'assets/Music/song11.mp3',
    'assets/Music/song12.mp3',
    'assets/Music/song13.mp3',
    'assets/Music/song14.mp3',
    'assets/Music/song15.mp3',
    'assets/Music/song16.mp3',
    'assets/Music/song17.mp3',
    'assets/Music/song18.mp3',
  ];

  bool _isPlaying = false;

  Future<void> playMusic(String musicPath) async {
    await _audioPlayer.setFilePath(musicPath);
    await _audioPlayer.play();
    notifyListeners();
  }

  Future<void> pauseMusic() async {
    await _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
    notifyListeners();
  }

  bool get isPlaying => _audioPlayer.playing;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
