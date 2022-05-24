import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zunada/screens/local_music/local_music.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        title: Text('Library'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Local music',style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.music_note,color: Color.fromRGBO(137,150,184,1),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LocalMusic(),));
              },
            ),
            ListTile(
              title: Text('Playlist',style: TextStyle(color: Colors.white),),
              leading: SvgPicture.asset('assets/icons/playlist.svg')
            ),
            ListTile(
              title: Text('Favorite Songs',style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.favorite_border,color: Color.fromRGBO(137,150,184,1),),
            ),
            ListTile(
              title: Text('Albums',style: TextStyle(color: Colors.white),),
              leading: SvgPicture.asset('assets/icons/album.svg')
            ),
            ListTile(
              title: Text('Artists',style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.star_border,color: Color.fromRGBO(137,150,184,1),),
            ),
            ListTile(
              title: Text('Podcast',style: TextStyle(color: Colors.white),),
              leading: SvgPicture.asset('assets/icons/podcasts.svg')
            ),
            ListTile(
              title: Text('Listening History',style: TextStyle(color: Colors.white),),
              leading: SvgPicture.asset('assets/icons/listening_history.svg')
            ),
            ListTile(
              title: Text('Downloaded',style: TextStyle(color: Colors.white),),
              leading: Icon(CupertinoIcons.arrow_down_circle,color: Color.fromRGBO(137,150,184,1),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 8),
              child: Text('Recently Played',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                title: Text('Avoid Things',style: TextStyle(color: Colors.white),),
                subtitle: Text('TEMS',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.more_vert,color: Colors.white),
                leading: Image.asset('assets/images/tems.jpg'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
