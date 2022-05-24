import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zunada/components/music_bottom_sheet.dart';
import 'package:zunada/screens/music_player.dart';

class LocalSong extends StatefulWidget {
  @override
  State<LocalSong> createState() => _LocalSongState();
}

class _LocalSongState extends State<LocalSong> {
  int order = 1;
  int _radiovalue = -1;

  OrderType checkOrder(){
    if(order == 1){
      return OrderType.ASC_OR_SMALLER;
    }else{
      return OrderType.DESC_OR_GREATER;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Icon(CupertinoIcons.arrow_up_arrow_down),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          color: Colors.black87,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('Order By',style: TextStyle(fontSize: 20)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ascending',style: TextStyle(color: Colors.white),),
                                  Radio(
                                    value: 1,
                                    groupValue: _radiovalue,
                                    onChanged: (value) => _handleChange,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Descending',style: TextStyle(color: Colors.white)),
                                  Radio(
                                      value: 2,
                                      groupValue: _radiovalue,
                                      onChanged: (value) => null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.list),
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<List<SongModel>>(
                future: OnAudioQuery().querySongs(
                  orderType: checkOrder(),
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if(item.data == null){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  //no songs found
                  if(item.data!.isEmpty){
                    return const Center(child: Text("No Songs Found"),);
                  }
                  // songList = snapshot.data!;
                  return ListView.builder(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        item.data![index].title,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,),
                      subtitle: Text(item.data![index].artist!,style: TextStyle(color: Colors.white),),
                      trailing: GestureDetector(
                        child: Icon(Icons.more_vert,color: Colors.white,),
                        onTap:() {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => MusicBottomSheet(songModel: item.data!,tileIndex: index,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              )
                            )
                          );
                        },
                      ),
                      onTap: () async {
                        String? uri = item.data![index].uri;
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MusicPlayer(
                          Uri: uri!,songModel: item.data!,tileIndex: index,),)
                        );
                      },
                    ),
                  );
                }
            ),
          )
        ],
      )
    );
  }
  void _handleChange(int value){
    setState(() {
      _radiovalue = value;
    });
    switch(_radiovalue){
      case 0:
        setState(() {
          order = 1;
        });
        break;
      case 1:
        setState(() {
          order = 2;
        });
        break;
    }
  }
}
