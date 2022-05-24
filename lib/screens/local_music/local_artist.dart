import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalArtist extends StatefulWidget {
  @override
  State<LocalArtist> createState() => _LocalArtistState();
}

class _LocalArtistState extends State<LocalArtist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      body: FutureBuilder<List<ArtistModel>>(
          future: OnAudioQuery().queryArtists(
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
            sortType: ArtistSortType.ARTIST
          ),
          builder: (context, item) {
            if(item.data == null){
              return const Center(child: CircularProgressIndicator(),);
            }
            //no songs found
            if(item.data!.isEmpty){
              return const Center(child: Text("No Songs Found"),);
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('(${item.data!.length} Artist)'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.arrow_up_arrow_down),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.ARTIST,
                      ),
                      title: Text(item.data![index].artist,style: TextStyle(color: Colors.white),),
                      subtitle: Text(item.data![index].numberOfTracks.toString(),style: TextStyle(color: Colors.white),),
                    ),
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}
