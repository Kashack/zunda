import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArtistCard extends StatelessWidget {
  String upperText;
  String lowerText;
  String artistImage;

  ArtistCard({required this.upperText, required this.lowerText, required this.artistImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      upperText,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          artistImage,
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: SvgPicture.asset(
                            'assets/icons/play.svg',height: 30,width: 30,)
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      lowerText,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 10),
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(37, 37, 40, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(20)),
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
