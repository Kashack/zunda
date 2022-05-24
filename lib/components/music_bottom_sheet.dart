import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicBottomSheet extends StatelessWidget {
  final List<SongModel> songModel;
  final int tileIndex;


  MusicBottomSheet({required this.songModel, required this.tileIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(27, 32, 57, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(songModel[tileIndex].title),
              subtitle: Text(songModel[tileIndex].artist!),
              textColor: Colors.white,
              leading: QueryArtworkWidget(
                id: songModel[tileIndex].id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(10),
              ),
            ),
            Divider(
              color: Colors.white70,
              thickness: 1,
            ),
            ListTile(
              title: Text('Favorite'),
              textColor: Colors.white,
              leading: Icon(Icons.favorite_border,color: Colors.white,),
            ),
            ListTile(
              title: Text('Add to playlist'),
              textColor: Colors.white,
              leading: Icon(Icons.add_box_outlined,color: Colors.white,),
            ),
            ListTile(
              title: Text('Set as Ringtone'),
              textColor: Colors.white,
              leading: Icon(Icons.notifications_none_outlined,color: Colors.white,),
            ),
            ListTile(
              title: Text('Play next'),
              textColor: Colors.white,
              leading: Icon(Icons.playlist_play,color: Colors.white,),
            ),
            ListTile(
              title: Text('Delete'),
              textColor: Colors.white,
              leading: Icon(Icons.delete_outline_outlined,color: Colors.white,),
            ),

          ],
        ),
      ),
    );
  }
}