import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupArtistCard extends StatelessWidget {
  String Title;
  String cardImage;

  GroupArtistCard({required this.Title, required this.cardImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14)),
                        child: Image.asset(
                          cardImage,
                          width: 130,
                          height: 130,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 7,
                          child: SvgPicture.asset(
                              'assets/icons/play.svg'))
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 130,
                    alignment: Alignment.center,
                    child: Text(
                      Title,
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(37, 37, 40, 1),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  border: Border.all(
                      width: 3.0,
                      color: Color.fromRGBO(196, 196, 196, 1))
              ),
            ),
          ],
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.headset,
                size: 16,
              ),
              Text(
                '20k',
                style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontSize: 12),
              ),
              SizedBox(width: 8,),
              Icon(Icons.favorite,size: 16,),
              Text(
                '20k',
                style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontSize: 12),
              ),
              SizedBox(width: 8),
              SvgPicture.asset('assets/icons/subscriber_icon.svg'),
              Text(
                '20k',
                style: TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}