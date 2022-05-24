import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zunada/screens/user_profile.dart';

class ArtistProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage('assets/images/tems.jpg'),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ));
            },
          ),
        ),
        title: Text('Tems'),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
              child: TextButton(
                onPressed: () {

                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: [
                        WidgetSpan(child: SvgPicture.asset('assets/icons/currency_zunada.svg',height: 18,)),
                        TextSpan(
                            text: '10,000',
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      //image
                      Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            'assets/images/tems.jpg',
                            width: 110,
                            height: 110,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      //@Artist
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(8),
                          child: Text('@Temsbaby',style: TextStyle(fontWeight: FontWeight.w600),)),
                    ],
                  ),
                ),
                // Container(
                //   alignment: Alignment.topRight,
                //     child: Icon(Icons.more_vert,color: Color.fromRGBO(137,150,184,1),)
                // )
              ],
            ),
          ),
          //Album,Likes,Listen
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: [
                        TextSpan(text: '2\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        TextSpan(text: 'Album'),
                      ]
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: [
                        TextSpan(text: '15k\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        TextSpan(text: 'Listens'),
                      ]
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      children: [
                        TextSpan(text: '17k\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        TextSpan(text: 'Likes'),
                      ]
                  ),
                ),
              ],
            ),
          ),
          //Follow,Tips
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Colors.redAccent,
                child: Text('Follow',style: TextStyle(color: Colors.white),),
                minWidth: 140,
                onPressed: () {

                },
              ),
              MaterialButton(
                color: Color.fromRGBO(37, 37, 40, 1),
                child: Text('Tip \$',style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 1.0, color: Colors.white),
                ),
                onPressed: () {

                },
              ),
            ],
          ),
          //Artist Biography
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            child: Text('Temilade Openiyi (born 11 June 1995), better known by her stage name Tems, is a Nigerian singer. In 2021, she earned two US top 40 entries on the Billboard',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          //Artist status
          Container(
            height: 120,
            margin: EdgeInsets.all(8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder:(context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          'assets/images/tems.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text('For Broken Ears'),
                    ],
                  ),
              ),
            ),
          ),
          //Artist Songs
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 6,
            itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.only(top: 8),
                color: Color.fromRGBO(37, 37, 40, 1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('${index + 1}'),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                'assets/images/tems.jpg',
                                width: 110,
                                height: 110,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              child: Icon(Icons.play_circle_outline,size: 50,color: Colors.white,),
                              left: 0,
                              top: 0,
                              bottom: 0,
                              right: 0,
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPlayer(Uri: '',),));
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Tems - Avoid Things'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('65 listening'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {

                                  },
                                  icon: Icon(Icons.favorite,color:Color.fromRGBO(249, 71, 71, 1))
                              ),
                              IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(Icons.add,color:Color.fromRGBO(249, 71, 71, 1))
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Icon(Icons.more_vert,color: Colors.redAccent,)
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
}
