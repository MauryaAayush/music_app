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

  bool _isFavorited = false;

  bool get isFavorited => _isFavorited;

  List mainList = [
    {
      'image': "https://c.saavncdn.com/artists/Mohit_Chauhan_500x500.jpg",
      'music': 'assets/Music/song1.mp3',
      'name': 'Aaya fir vo najar ese'
    },
    {
      'image':
          "https://c.saavncdn.com/artists/Gaurav_Dagaonkar_20191216113105_500x500.jpg",
      'music': 'assets/Music/song2.mp3',
      'name': "Main Dhoondne Ko Zamaane"
    },
    {
      'image':
          "https://c.saavncdn.com/artists/Parampara_Thakur_20191130070743_500x500.jpg",
      'music': 'assets/Music/song3.mp3',
      'name': 'Dil ke Pass '
    },
    {
      'image': "https://c.saavncdn.com/151/Ek-Villain-Hindi-2014-500x500.jpg",
      'music': 'assets/Music/song4.mp3',
      'name': 'Jo  tu mera hamdarad hai'
    },
    {
      'image':
          "https://c.saavncdn.com/artists/Amarjeet_Jaikar_000_20230315131159_500x500.jpg",
      'music': 'assets/Music/song5.mp3',
      'name': 'Teri Galliya'
    },
    {
      'image':
          "https://c.saavncdn.com/945/Hasi-Ban-Gaye-Hindi-2023-20230608172234-500x500.jpg",
      'music': 'assets/Music/song6.mp3',
      'name': 'Hasi ban gae'
    },
    {
      'image':
          "https://c.saavncdn.com/135/Aam-Jahe-Munde-Punjabi-2020-20240424043015-500x500.jpg",
      'music': 'assets/Music/song7.mp3',
      'name': 'Aam jehe munde'
    },
    {
      'image':
          "https://c.saavncdn.com/252/Laapataa-Ladies-Hindi-2024-20240213151004-500x500.jpg",
      'music': 'assets/Music/song8.mp3',
      'name': 'One Love'
    },
    {
      'image': "https://c.saavncdn.com/821/Dilwale-Hindi-2015-500x500.jpg",
      'music': 'assets/Music/song9.mp3',
      'name': 'Tukur Tukur'
    },
    {
      'image': "https://c.saavncdn.com/821/Dilwale-Hindi-2015-500x500.jpg",
      'music': 'assets/Music/song10.mp3',
      'name': 'Man ma Emotion'
    },
    {
      'image':
          "https://c.saavncdn.com/888/Forever-2-Hindi-2012-20190924060933-500x500.jpg",
      'music': 'assets/Music/song11.mp3',
      'name': 'Keh du tumhe'
    },
    {
      'image':
          "https://c.saavncdn.com/994/Genius-Hindi-2018-20240408213802-500x500.jpg",
      'music': 'assets/Music/song12.mp3',
      'name': 'Dill meri Na sune'
    },
    {
      'image':
          "https://c.saavncdn.com/994/Genius-Hindi-2018-20240408213802-500x500.jpg",
      'music': 'assets/Music/song13.mp3',
      'name': 'Tera Fitoor'
    },
    {
      'image': "https://c.saavncdn.com/930/Heropanti-2014-500x500.jpg",
      'music': 'assets/Music/song14.mp3',
      'name': 'Rabba Rabba'
    },
    {
      'image':
          "https://c.saavncdn.com/092/ANIMAL-Hindi-2023-20231124191036-500x500.jpg",
      'music': 'assets/Music/song15.mp3',
      'name': 'Arjan vally'
    },
    {
      'image':
          "https://c.saavncdn.com/352/Saari-Duniya-Jalaa-Denge-Extended-Film-Version-From-ANIMAL-Hindi-2023-20231222191004-500x500.jpg",
      'music': 'assets/Music/song16.mp3',
      'name': 'Saari Duniya jalaa denge'
    },
    {
      'image':
          "https://c.saavncdn.com/624/Abrar-s-Entry-Jamal-Kudu-From-ANIMAL-Hindi-2023-20231206121002-500x500.jpg",
      'music': 'assets/Music/song17.mp3',
      'name': 'Jabal jabal'
    },
    {
      'image':
          "https://c.saavncdn.com/418/Batti-Gul-Meter-Chalu-Hindi-2018-20180908134024-500x500.jpg",
      'music': 'assets/Music/song18.mp3',
      'name': 'Dekhte Dekhte'
    },
  ];

  SongService _songService = SongService();
  List<Song> songs = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateApiClickedSongs(String song, String songName, String image) {
    mainList[1]['name'] = songName;
    mainList[1]['image'] = image;
    mainList[1]['music'] = song;

    currentIndex = 1;

    playMusic(song, image, songName);
    notifyListeners();
  }

  Future<void> playMusic(String link, String imageUrl, String title) async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(
          link,
          metas: Metas(
            title: title,
            image: MetasImage.network(imageUrl),
          ),
        ),
        showNotification: true,
        loopMode: LoopMode.none,
      );
    } catch (t) {
      //mp3 unreachable
      print(t);
    }
  }

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

  void toggleFavorite() {
    _isFavorited = !_isFavorited;
    notifyListeners();
  }

  void openSong(List songList, int index) {
    currentIndex = index;
    assetsAudioPlayer.open(
      Audio(
        songList[currentIndex]['music'],
        metas: Metas(
          title: songList[currentIndex]['title'],
          artist: songList[currentIndex]['artist'],
          album: songList[currentIndex]['album'],
          image: MetasImage.network(
              songList[currentIndex]['image']), // Add image here
        ),
      ),
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
    super.dispose();
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
