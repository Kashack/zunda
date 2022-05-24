import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zunada/screens/home_page/home_page.dart';
import 'package:zunada/screens/on_boarding/login.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  // const VerifyEmailPage({Key? key}) : super(key: key);
  bool isEmailVerified = false;
  bool canResendEmail =false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? timer;

  @override
  void initState() {
    super.initState();
     isEmailVerified = _auth.currentUser!.emailVerified;
     if(!isEmailVerified){
       sendVerificationEmail();
       timer = Timer.periodic(
           Duration(seconds: 3),
             (_) => checkEmailVerified(),
       );
     }
  }

  @override
  void dispose() {
    timer?.cancel();
    FirebaseAuth.instance.signOut();
    super.dispose();
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }
  Future sendVerificationEmail() async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified == true
      ? const HomePage()
      : Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'A verification email has been sent to your email',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
          textAlign: TextAlign.center,
        ),
        ElevatedButton.icon(
          onPressed: () => sendVerificationEmail(),
          icon: Icon(Icons.email,size: 32),
          label: Text(
            'Resent Email',
            style: TextStyle(fontSize: 24),
          ),
        ),
        TextButton(onPressed: (){
          FirebaseAuth.instance.signOut()
              .then((value) => Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false)
          );
        }, child:Text("Cancel"))
      ],
    ),
  );
}
