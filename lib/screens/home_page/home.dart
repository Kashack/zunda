import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zunada/components/artist_card.dart';
import 'package:zunada/components/group_artist_card.dart';
import 'package:zunada/screens/artist_profile.dart';
import 'package:zunada/screens/user_profile.dart';
import '../../util/my_search_delegate.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/zino.jpg'),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(),));
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Search for Artist,songs, albums and playlists',
                      overflow: TextOverflow.ellipsis,
                    )),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 37, 40, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1.0, color: Colors.white)),
              ),
              onTap: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8.0),
            child: TextButton(
              onPressed: () {

              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    children: [
                      WidgetSpan(child: SvgPicture.asset('assets/icons/currency_zunada.svg',height: 18,)),
                      TextSpan(
                          text: '1000',
                          style: TextStyle(fontSize: 14)
                      )
                    ]
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(37, 37, 40, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1.0, color: Colors.white),
                ),
              ),
            )
          )
        ],
      ),
      body: ListView (
        children: [
          //Top Artist33
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      'Top Artist',
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15),
                    )),
                Text('VIEW ALL',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 12,
                )
              ],
            ),
          ),
          Container(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                child: InkWell(
                  child: ArtistCard(upperText: 'FOCUS',lowerText: 'TEMS',artistImage: 'assets/images/tems.jpg',),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistProfile(),));
                  },
                ),
              ),
              itemCount: 5,
            )
          ),
          //Top Albums
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      'Top Albums',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    )),
                Text('VIEW ALL',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 12,
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GroupArtistCard(cardImage:'assets/images/freestyle.jpg',Title: 'REMA FREESTYLE EP',),
              ),
            ),
          ),
          //Upcoming Artist
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      'Upcoming Artist',
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                    )),
                Text('VIEW ALL',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 12,
                )
              ],
            ),
          ),
          Container(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8.0),
                  child: ArtistCard(lowerText: 'Zinolesky',artistImage: 'assets/images/zino.jpg',upperText: 'FOCUS',),
                ),
                itemCount: 5,
              )
          ),
          //Top Albums
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      'Best New',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    )),
                Text('VIEW ALL',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 12,
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: InkWell(
                  child: GroupArtistCard(cardImage: 'assets/images/wizkid.jpg',Title : "FRESH AFROBEAT"),
                  onTap: () {

                  },
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
  // backgroundColor: Color.fromRGBO(37, 37, 40, 1),
  // labelStyle: TextStyle(color: Colors.white),
  // side: BorderSide(width: 1.0, color: Colors.white),
}
