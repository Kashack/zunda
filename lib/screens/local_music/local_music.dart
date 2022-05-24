import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zunada/screens/local_music/local_album.dart';
import 'package:zunada/screens/local_music/local_artist.dart';
import 'package:zunada/screens/local_music/local_song.dart';

class LocalMusic extends StatefulWidget {
  @override
  State<LocalMusic> createState() => _LocalMusicState();
}

class _LocalMusicState extends State<LocalMusic> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        appBar: AppBar(
          title: Text('Local Music'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(27, 32, 57, 1),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Songs',),
              Tab(text: 'Artists',),
              Tab(text: 'Albums',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LocalSong(),
            LocalArtist(),
            LocalAlbum(),
          ],
        ),
      ),
    );
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    if(!kIsWeb){
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if(!permissionStatus){
        await _audioQuery.permissionsRequest();
      }
      //ensure build method is called
      setState(() { });
    }
  }
}
