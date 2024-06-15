import 'dart:convert';
import 'package:http/http.dart' as http;
//
// class Song {
//   final String image;
//   final String mediaUrl;
//   final String song;
//   final String singers;
//   final int playCount;
//
//   Song(
//       {required this.image,
//         required this.mediaUrl,
//         required this.song,
//         required this.singers,
//         required this.playCount});
//
//   factory Song.fromJson(Map<String, dynamic> json) {
//     return Song(
//         image: json['image'],
//         mediaUrl: json['media_url'],
//         song: json['song'],
//         singers: json['singers'],
//         playCount: json['play_count']);
//   }
// }
//
//


import 'dart:convert';

class Song {
  final String id;
  final String name;
  final String type;
  final String year;
  final int duration;
  final String label;
  final bool explicitContent;
  final int playCount;
  final String language;
  final bool hasLyrics;
  final String url;
  final String copyright;
  final Album album;
  final List<Artist> primaryArtists;
  final List<Artist> featuredArtists;
  final List<Artist> allArtists;
  final List<ImageUrl> images;
  final List<DownloadUrl> downloadUrls;

  Song({
    required this.id,
    required this.name,
    required this.type,
    required this.year,
    required this.duration,
    required this.label,
    required this.explicitContent,
    required this.playCount,
    required this.language,
    required this.hasLyrics,
    required this.url,
    required this.copyright,
    required this.album,
    required this.primaryArtists,
    required this.featuredArtists,
    required this.allArtists,
    required this.images,
    required this.downloadUrls,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      year: json['year'],
      duration: json['duration'],
      label: json['label'],
      explicitContent: json['explicitContent'],
      playCount: json['playCount'],
      language: json['language'],
      hasLyrics: json['hasLyrics'],
      url: json['url'],
      copyright: json['copyright'],
      album: Album.fromJson(json['album']),
      primaryArtists: (json['artists']['primary'] as List)
          .map((i) => Artist.fromJson(i))
          .toList(),
      featuredArtists: (json['artists']['featured'] as List)
          .map((i) => Artist.fromJson(i))
          .toList(),
      allArtists: (json['artists']['all'] as List)
          .map((i) => Artist.fromJson(i))
          .toList(),
      images: (json['image'] as List).map((i) => ImageUrl.fromJson(i)).toList(),
      downloadUrls: (json['downloadUrl'] as List)
          .map((i) => DownloadUrl.fromJson(i))
          .toList(),
    );
  }
}

class Album {
  final String id;
  final String name;
  final String url;

  Album({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}

class Artist {
  final String id;
  final String name;
  final String role;
  final List<ImageUrl> images;
  final String type;
  final String url;

  Artist({
    required this.id,
    required this.name,
    required this.role,
    required this.images,
    required this.type,
    required this.url,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      images: (json['image'] as List).map((i) => ImageUrl.fromJson(i)).toList(),
      type: json['type'],
      url: json['url'],
    );
  }
}

class ImageUrl {
  final String quality;
  final String url;

  ImageUrl({
    required this.quality,
    required this.url,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      quality: json['quality'],
      url: json['url'],
    );
  }
}

class DownloadUrl {
  final String quality;
  final String url;

  DownloadUrl({
    required this.quality,
    required this.url,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      quality: json['quality'],
      url: json['url'],
    );
  }
}


  // Example JSON data
  // String jsonString = '''{
  //     "id": "rMsABreY",
  //     "name": "Thar",
  //     "type": "song",
  //     "year": "2023",
  //     "duration": 160,
  //     "label": "Dollar Music",
  //     "explicitContent": false,
  //     "playCount": 1796051,
  //     "language": "unknown",
  //     "hasLyrics": false,
  //     "url": "https://www.jiosaavn.com/song/thar/AiUYcDZCUmo",
  //     "copyright": "© 2023 Dollar music",
  //     "album": {
  //         "id": "44508819",
  //         "name": "Thar",
  //         "url": "https://www.jiosaavn.com/album/thar/Fen8kEsA4UA_"
  //     },
  //     "artists": {
  //         "primary": [
  //             {
  //                 "id": "768187",
  //                 "name": "Jassi Kirarkot",
  //                 "role": "primary_artists",
  //                 "image": [
  //                     {
  //                         "quality": "50x50",
  //                         "url": "https://c.saavncdn.com/artists/Jassi_Kirarkot_000_20240409093018_50x50.jpg"
  //                     },
  //                     {
  //                         "quality": "150x150",
  //                         "url": "https://c.saavncdn.com/artists/Jassi_Kirarkot_000_20240409093018_150x150.jpg"
  //                     },
  //                     {
  //                         "quality": "500x500",
  //                         "url": "https://c.saavncdn.com/artists/Jassi_Kirarkot_000_20240409093018_500x500.jpg"
  //                     }
  //                 ],
  //                 "type": "artist",
  //                 "url": "https://www.jiosaavn.com/artist/jassi-kirarkot-songs/W7vsuYZ-x6s_"
  //             },
  //             {
  //                 "id": "7273437",
  //                 "name": "Komal Chaudhary",
  //                 "role": "primary_artists",
  //                 "image": [
  //                     {
  //                         "quality": "50x50",
  //                         "url": "https://c.saavncdn.com/243/Jutti-Single-Hindi-2019-20191125002945-50x50.jpg"
  //                     },
  //                     {
  //                         "quality": "150x150",
  //                         "url": "https://c.saavncdn.com/243/Jutti-Single-Hindi-2019-20191125002945-150x150.jpg"
  //                     },
  //                     {
  //                         "quality": "500x500",
  //                         "url": "https://c.saavncdn.com/243/Jutti-Single-Hindi-2019-20191125002945-500x500.jpg"
  //                     }
  //                 ],
  //                 "type": "artist",
  //                 "url": "https://www.jiosaavn.com/artist/komal-chaudhary-songs/alGNFihrqJI_"
  //             },
  //             {
  //                 "id": "15997711",
  //                 "name": "Love Kataria",
  //                 "role": "primary_artists",
  //                 "image": [],
  //                 "type": "artist",
  //                 "url": "https://www.jiosaavn.com/artist/love-kataria-songs/44q,q5R8S,c_"
  //             },
  //             {
  //                 "id": "14068392",
  //                 "name": "Khushi Baliyan",
  //                 "role": "primary_artists",
  //                 "image": [
  //                     {
  //                         "quality": "50x50",
  //                         "url": "https://c.saavncdn.com/artists/Khushi_Baliyan_000_20230313112622_50x50.jpg"
  //                     },
  //                     {
  //                         "quality": "150x150",
  //                         "url": "https://c.saavncdn.com/artists/Khushi_Baliyan_000_20230313112622_150x150.jpg"
  //                     },
  //                     {
  //                         "quality": "500x500",
  //                         "url": "https://c.saavncdn.com/artists/Khushi_Baliyan_000_20230313112622_500x500.jpg"
  //                     }
  //                 ],
  //                 "type": "artist",
  //                 "url": "https://www.jiosaavn.com/artist/khushi-baliyan-songs/yLTiCvfGj8Y_"
  //             }
  //         ],
  //         "featured": [],
  //         "all": [
  //             {
  //                 "id": "7215101",
  //                 "name": "Deepty",
  //                 "role": "music",
  //                 "image": [
  //                     {
  //                         "quality": "50x50",
  //                         "url": "https://c.saavncdn.com/785/Hathkad-Single-Punjabi-2019-20191223043632-50x50.jpg"
  //                     },
  //                     {
  //                         "quality": "150x150",
  //                         "url": "https://c.saavncdn.com/785/Hathkad-Single-Punjabi-2019-20191223043632-150x150.jpg"
  //                     },
  //                     {
  //                         "quality": "500x500",
  //                         "url": "https://c.saavncdn.com/785/Hathkad-Single-Punjabi-2019-20191223043632-500x500.jpg"
  //                     }
  //                 ],
  //                 "type": "artist",
  //                 "url": "https://www.jiosaavn.com/artist/deepty-songs/Y-,XUEgv5JA_"
  //             }
  //         ]
  //     },
  //     "image": [
  //         {
  //             "quality": "50x50",
  //             "url": "https://c.saavncdn.com/445/Thar-Hindi-2023-20230508212749-50x50.jpg"
  //         },
  //         {
  //             "quality": "150x150",
  //             "url": "https://c.saavncdn.com/445/Thar-Hindi-2023-20230508212749-150x150.jpg"
  //         },
  //         {
  //             "quality": "500x500",
  //             "url": "https://c.saavncdn.com/445/Thar-Hindi-2023-20230508212749-500x500.jpg"
  //         }
  //     ],
  //     "downloadUrl": [
  //         {
  //             "quality": "12kbps",
  //             "url": "https://aac.saavncdn.com/445/5e32e712147b79de8e5da11afed28761_12.mp4"
  //         },
  //         {
  //             "quality": "48kbps",
  //             "url": "https://aac.saavncdn.com/445/5e32e712147b79de8e5da11afed28761_48.mp4"
  //         },
  //         {
  //             "quality": "96kbps",
  //             "url": "https://aac.saavncdn.com/445/5e32e712147b79de8e5da11afed28761_96.mp4"
  //         },
  //         {
  //             "quality": "160kbps",
  //             "url": "https://aac.saavncdn.com/445/5e32e712147b79de8e5da11afed28761_160.mp4"
  //         }
  //     ]
  // }''';
  //
  // Map<String, dynamic> jsonData = jsonDecode(jsonString);
  // Song song = Song.fromJson(jsonData);
  //
  // print('Song name: ${song.name}');
  // print('Album name: ${song.album.name}');
  // print('Primary artists:');
  // song.primaryArtists.forEach((artist) {
  //   print('  ${artist.name}');
  // });
  // print('Download URLs:');
  // song.downloadUrls.forEach((url) {
  //   print('  ${url.quality}: ${url.url}');
  // });

class SongService {
  final String baseUrl = 'http://192.168.0.108:5100';

  Future<List<Song>> searchSongs(String query) async {
    final encodedQuery = query.replaceAll(' ', ''); // Remove spaces
    final response =
    await http.get(Uri.parse('https://saavn.dev/api/search/songs?query=$query'));

    // log(response.code);
    // print(response.statusCode);
    
    print(response.body);

    if (response.statusCode == 200) {
      List<Song> jsonList = json.decode(response.body);

      List<Song> songs = jsonList.map((json) => Song.fromJson(json as Map<String, dynamic>)).toList();

      return songs;
    } else {
      throw Exception('Failed to load songs');
    }

  }
}