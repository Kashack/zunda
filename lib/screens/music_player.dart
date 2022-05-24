import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zunada/components/playlist_bottom_sheet.dart';
import 'package:zunada/util/music_notification.dart';

class MusicPlayer extends StatefulWidget {
  String Uri;
  List<SongModel>? songModel;
  int? tileIndex;
  MusicPlayer({required this.Uri,this.songModel,this.tileIndex});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Color generalColor = Color.fromRGBO(165, 192, 255, 0.7);
  double rating = 0;
  Color textColor = Color.fromRGBO(196, 196, 196, 1);
  bool openMore = false;
  String currentSongTitle = '';
  int currentIndex = 0;
  late ConcatenatingAudioSource _playlist;
  AudioPlayer _player = AudioPlayer();

  void playSong() async {
    _playlist = createPlaylist(widget.songModel!);
    await _player.setAudioSource(
      _playlist,
      initialIndex: widget.tileIndex
    );
    await _player.play();
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?,DurationState>(
          _player.positionStream,_player.durationStream, (position, duration) => DurationState(
        postion: position,total: duration ?? Duration.zero
      ));

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }


  @override
  void initState() {
    super.initState();
    playSong();
    _player.currentIndexStream.listen((event) {
      if(event != null){
        _updateCurrentPlayingSongPlaylist(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(102, 89, 53, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(child: Text('Music ',style: TextStyle(fontSize: 14))),
              VerticalDivider(width: 20.0,color: Color.fromRGBO(155, 45, 239, 1),thickness: 1,),
              GestureDetector(child: Text('lyrisc',style: TextStyle(color: Colors.grey,fontSize: 14),)),
            ],
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 8),
            child: MaterialButton(
              minWidth: 16,
              color: Color.fromRGBO(37, 37, 40, 1),
              child: Text('Tip \$',style: TextStyle(color: Colors.white),),
              shape: Border.all(color: Colors.white,width: 1.0),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300,
              height: 250,
              padding:  EdgeInsets.symmetric(vertical: 10),
              child: QueryArtworkWidget(
                id: widget.songModel![currentIndex].id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(10),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Column(
                  //   children: [
                  //     Icon(Icons.how_to_vote,),
                  //     Text('Vote',style: TextStyle(color: textColor,fontSize: 10))
                  //   ],
                  // ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(widget.songModel![currentIndex].title.toString(),
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(widget.songModel![currentIndex].artist!,
                            style: TextStyle(color: generalColor)
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //upper Slide
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/download.svg',height: 24,width: 24,),
                      Text('Download',style: TextStyle(color: textColor,fontSize: 10))
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset('assets/icons/comment_minus.svg',height: 24,width: 24,),
                      Text('Comment',style: TextStyle(color: textColor,fontSize: 10))
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.favorite_border,color: Color.fromRGBO(137, 150, 184, 0.6),),
                      Text('Favorite',style: TextStyle(color: textColor,fontSize: 10))
                    ],
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Icon(Icons.playlist_play,color: Color.fromRGBO(137, 150, 184, 0.6),),
                        Text('Playlist',style: TextStyle(color: textColor,fontSize: 10))
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => PlaylistBottomSheet(
                          playlist: _playlist,
                          playlistSong: widget.songModel!,),
                      );
                      // final title = _playlist.children.toSongModel().first.title;
                      // print(title);
                    },
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.more_vert,color: Color.fromRGBO(137, 150, 184, 0.6),),
                        onTap: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (context) => MusicBottomSheet(),
                          // );
                        },
                      ),
                      Text('More',style: TextStyle(color: textColor,fontSize: 10))
                    ],
                  ),
                ],
              ),
            ),
            //slider
            Column(
              children: [
                StreamBuilder<DurationState>(
                  stream: _durationStateStream,
                  builder: (context, snapshot) {
                    final durationState = snapshot.data;
                    final progress = durationState?.postion ?? Duration.zero;
                    final total = durationState?.total ?? Duration.zero;
                    return ProgressBar(
                      thumbColor: Colors.white,
                      progress: progress,
                      total: total,
                      timeLabelTextStyle: TextStyle(color: Colors.white),
                      onSeek: (value) {
                        setState(() {
                          _player.seek(value);
                        });
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //shuffle
                    IconButton(
                        onPressed:() {
                          _player.shuffleModeEnabled ?
                          _player.setShuffleModeEnabled(false) : _player.setShuffleModeEnabled(true);
                        },
                        icon: StreamBuilder<bool>(
                          stream: _player.shuffleModeEnabledStream,
                          builder: (context, snapshot) {
                            final shuffleMode = snapshot.data;
                            if(shuffleMode == true){
                              print('false');
                              return const Icon(Icons.shuffle,color: Colors.blue,);
                            }
                            return const Icon(Icons.shuffle,color:Colors.white);
                          },
                        ),
                    ),
                    IconButton(
                      onPressed:() {
                        if(_player.hasPrevious){
                          _player.seekToPrevious();
                        }
                      },
                      icon: SvgPicture.asset('assets/icons/previous.svg'),
                      iconSize: 36,
                    ),
                    //pause
                    IconButton(
                      onPressed:() async{
                        if(_player.playing){
                          _player.pause();
                        }else{
                          if(_player.currentIndex != null){
                            _player.play();
                          }
                        }
                      },
                      icon: StreamBuilder<bool>(
                        stream: _player.playingStream,
                        builder: (context, snapshot) {
                          bool? playingState = snapshot.data;
                          if(playingState != null && playingState){
                            return SvgPicture.asset('assets/icons/pause.svg');
                          }
                          return const Icon(Icons.play_circle_fill_outlined,color: Colors.white);
                        },
                      ),
                      iconSize: 36,
                    ),
                    //next
                    IconButton(
                      onPressed:() {
                        if(_player.hasNext){
                          _player.seekToNext();
                        }
                      },
                      icon: SvgPicture.asset('assets/icons/next.svg'),
                      iconSize: 36,
                    ),
                    //loop,loop once
                    IconButton(
                      onPressed:() {
                        _player.loopMode == LoopMode.one ?
                            _player.setLoopMode(LoopMode.all) : _player.setLoopMode(LoopMode.one);
                      },
                      icon: StreamBuilder<LoopMode>(
                        stream: _player.loopModeStream,
                        builder: (context, snapshot) {
                          final loopMode = snapshot.data;
                          if(LoopMode.one == loopMode){
                            return const Icon(Icons.repeat_one,color: Colors.white,);
                          }
                          return const Icon(Icons.repeat,color:Colors.white);
                        },
                      ),
                      iconSize: 24,
                    ),
                  ],
                )
              ],
            ),

          ],
        ),
      )
    );
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songModel) {
    List<AudioSource> sources = [];
    for(var song in songModel){
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    print(songModel);
    return ConcatenatingAudioSource(children: sources);
  }

  void _updateCurrentPlayingSongPlaylist(int event) {
    setState(() {
      if(widget.songModel!.isNotEmpty){
        currentSongTitle = widget.songModel![event].title;
        currentIndex = event;
      }
    });
  }
}

class DurationState{
  Duration postion, total;
  DurationState({this.postion = Duration.zero, this.total = Duration.zero});
}
