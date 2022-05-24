import 'package:flutter/material.dart';

class Notify extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        title: Text('Notification'),
        centerTitle: true,
      ),
    );
  }
}
