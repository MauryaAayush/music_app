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

class MusicProvider extends ChangeNotifier {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  Stream<bool> get isPlaying => assetsAudioPlayer.isPlaying;

  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  int currentIndex = 0;

  // void openMusic(int index,List<String> songList) {
  //   currentIndex = index;
  //   assetsAudioPlayer.open(
  //     Audio(musicList[index]),
  //     autoStart: true,
  //     showNotification: true,
  //   );
  //   notifyListeners();
  // }
  //
  // void nextSong(List<String> musicList) {
  //   if (currentIndex < musicList.length - 1) {
  //     currentIndex++;
  //     assetsAudioPlayer.stop();
  //     openMusic(musicList, currentIndex);
  //     notifyListeners();
  //   }
  //
  //   void playPause() {
  //     assetsAudioPlayer.playOrPause();
  //     notifyListeners();
  //   }
  //
  //
  //
  //
  //
  // }


  bool _isFavorited = false;

  bool get isFavorited => _isFavorited;

  void toggleFavorite() {
    _isFavorited = !_isFavorited;
    notifyListeners();
  }


  List mainList = [
    {
      'image': 'assets/images/image1.jpg',
      'music': 'assets/Music/song1.mp3',
      'name': 'Aaya fir vo najar ese'
    },
    {
      'image': 'assets/images/image2.jpg',
      'music': 'assets/Music/song2.mp3',
      'name': "Main Dhoondne Ko Zamaane Mein"
    },
    {
      'image': 'assets/images/image3.jpg',
      'music': 'assets/Music/song3.mp3',
      'name': 'Dil ke Pass '
    },
    {
      'image': 'assets/images/image4.jpg',
      'music': 'assets/Music/song4.mp3',
      'name': 'Jo  tu mera hamdarad hai'
    },
    {
      'image': 'assets/images/image5.jpg',
      'music': 'assets/Music/song5.mp3',
      'name': 'Teri Galliya'
    },
    {
      'image': 'assets/images/image6.jpg',
      'music': 'assets/Music/song6.mp3',
      'name': 'Hasi ban gae'
    },
    {
      'image': 'assets/images/image7.jpg',
      'music': 'assets/Music/song7.mp3',
      'name': 'Aam jehe munde'
    },
    {
      'image': 'assets/images/image8.jpg',
      'music': 'assets/Music/song8.mp3',
      'name': 'One Love'
    },
    {
      'image': 'assets/images/image9.jpg',
      'music': 'assets/Music/song9.mp3',
      'name': 'Tukur Tukur'
    },
    {
      'image': 'assets/images/image10.jpg',
      'music': 'assets/Music/song10.mp3',
      'name': 'Man ma Emotion'
    },
    {
      'image': 'assets/images/image11.jpg',
      'music': 'assets/Music/song11.mp3',
      'name': 'Keh du tumhe'
    },
    {
      'image': 'assets/images/image12.jpg',
      'music': 'assets/Music/song12.mp3',
      'name': 'Dill meri Na sune'
    },
    {
      'image': 'assets/images/image13.jpg',
      'music': 'assets/Music/song13.mp3',
      'name': 'Tera Fitoor'
    },
    {
      'image': 'assets/images/image14.jpg',
      'music': 'assets/Music/song14.mp3',
      'name': 'Rabba Rabba'
    },
    {
      'image': 'assets/images/image15.jpg',
      'music': 'assets/Music/song15.mp3',
      'name': 'Arjan vally'
    },
    {
      'image': 'assets/images/image16.jpg',
      'music': 'assets/Music/song16.mp3',
      'name': 'Saari Duniya jala dege'
    },
    {
      'image': 'assets/images/image17.jpg',
      'music': 'assets/Music/song17.mp3',
      'name': 'Jabal jabal'
    },
    {
      'image': 'assets/images/image18.jpg',
      'music': 'assets/Music/song18.mp3',
      'name': 'Dekhte Dekhte'
    },
  ];

  void openSong(List songList, int index) {

    currentIndex = index;
    assetsAudioPlayer.open(
      Audio(songList[currentIndex]['music']),
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

  void nextSong(List songList) {
    if (currentIndex < songList.length - 1) {
      currentIndex++;
      assetsAudioPlayer.stop();
      openSong(songList, currentIndex);
      notifyListeners();
    }
  }

  void previousSong(List songList) {
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

}


class AudioPlayerProvider extends ChangeNotifier {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  Stream<bool> get isPlaying => assetsAudioPlayer.isPlaying;

  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  int currentIndex = 0;

  // void openSong(List<String> songList, int index) {
  //   currentIndex = index;
  //   assetsAudioPlayer.open(
  //     Audio(songList[currentIndex]),
  //     autoStart: true,
  //     showNotification: true,
  //   );
  //
  //   assetsAudioPlayer.currentPosition.listen((duration) {
  //     currentPosition = duration;
  //     notifyListeners();
  //   });
  //
  //   assetsAudioPlayer.current.listen((playingAudio) {
  //     totalDuration = playingAudio?.audio.duration ?? Duration.zero;
  //     notifyListeners();
  //   });
  // }
  //
  // void playPause() {
  //   assetsAudioPlayer.playOrPause();
  //   notifyListeners();
  // }
  //
  // void nextSong(List<String> songList) {
  //   if (currentIndex < songList.length - 1) {
  //     currentIndex++;
  //     assetsAudioPlayer.stop();
  //     openSong(songList, currentIndex);
  //     notifyListeners();
  //   }
  // }
  //
  // void previousSong(List<String> songList) {
  //   if (currentIndex > 0) {
  //     currentIndex--;
  //     assetsAudioPlayer.stop();
  //     openSong(songList, currentIndex);
  //     notifyListeners();
  //   }
  // }
  //
  // void seek(Duration position) {
  //   assetsAudioPlayer.seek(position);
  //   notifyListeners();
  // }
  //
  // void dispose() {
  //   assetsAudioPlayer.dispose();
  //   notifyListeners();
  // }
  //
  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = duration.inHours;
  //   final minutes = duration.inMinutes.remainder(60);
  //   final seconds = duration.inSeconds.remainder(60);
  //   return [
  //     if (hours > 0) hours,
  //     minutes,
  //     seconds,
  //   ].map(twoDigits).join(':');
  // }






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



