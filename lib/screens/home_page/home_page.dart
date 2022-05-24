import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zunada/screens/notification.dart';

import 'settings.dart';
import 'home.dart';
import 'library.dart';
import '../notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectindex = 0;
  final screens = [
    Home(),
    Library(),
    Notify(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      body: screens[_selectindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(37, 37, 40, 1),
        currentIndex: _selectindex,
        onTap: (value) {
          setState(() {
            _selectindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/logo_home.svg'),
            label: 'Home',
            backgroundColor: Color.fromRGBO(37, 37, 40, 1),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/library_icon.svg'),
            label: 'Library',
            backgroundColor: Color.fromRGBO(37, 37, 40, 1),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/notification.svg'),
            label: 'Notification',
            backgroundColor: Color.fromRGBO(37, 37, 40, 1),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/settings_icon.svg'),
            label: 'Setting',
            backgroundColor: Color.fromRGBO(37, 37, 40, 1),
          ),
        ],
      ),
    );
  }
}
