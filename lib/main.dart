import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zunada/screens/home_page/home_page.dart';
import 'package:zunada/screens/on_boarding/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // navigatorKey: ,
      title: 'zunda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.blue,
        textTheme: TextTheme(
          bodyText2:TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(196, 196, 196, 1)
        )
      ),
      home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomePage()
    );
  }
}
