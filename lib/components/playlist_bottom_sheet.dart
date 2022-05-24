import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistBottomSheet extends StatelessWidget {
  final List<SongModel> playlistSong;
  ConcatenatingAudioSource playlist;
  PlaylistBottomSheet({required this.playlist, required this.playlistSong});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(27, 32, 57, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Queue(${playlist.length} songs)'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<List<String>>(
                builder: (context, snapshot) => ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Expanded(
                                  child: Text('${playlistSong[index].title}',overflow: TextOverflow.ellipsis,)
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                playlist.removeAt(index);
                              },
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.white70,
                        )
                      ],
                    );
                  },
                ),
              )
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close',style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
