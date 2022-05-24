import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zunada/screens/on_boarding/login.dart';

class Settings extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Free Account',style: TextStyle(fontSize: 18),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(53, 237, 251, 1),
                                  Color.fromRGBO(45, 155, 239, 1),
                                  Color.fromRGBO(155, 45, 239, 1),
                                ]
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 40,
                        child: Text('Go to Premium',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Playback (Premium Feature)',style: TextStyle(fontSize: 18),),
                    SwitchListTile(
                      title: Text('Offline mode',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                      onChanged: (value) {

                      },
                    ),
                    SwitchListTile(
                      title: Text('Compress all my track',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                      },
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Audio (Premium Feature)',style: TextStyle(fontSize: 18),),
                    ListTile(
                      title: Text('Downloads quality',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1))),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Text('Streaming quality',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1))),
                      contentPadding: EdgeInsets.zero,
                    ),
                    SwitchListTile(
                      title: Text('Download using cellular',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                      },
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Playback (Premium Feature)',style: TextStyle(fontSize: 18),),
                    SwitchListTile(
                      title: Text('Offline mode',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                      onChanged: (value) {

                      },
                    ),
                    SwitchListTile(
                      title: Text('Compress all my track',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                      },
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notification',style: TextStyle(fontSize: 18),),
                    SwitchListTile(
                      title: Text('Enable notification',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: true,
                      contentPadding: EdgeInsets.zero,
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                      onChanged: (value) {

                      },
                    ),
                    SwitchListTile(
                      title: Text('Recommended Music',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                      },
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                    ),
                    SwitchListTile(
                      title: Text('Playlist updates',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                      },
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                    ),
                    SwitchListTile(
                      title: Text('Artisit update',style: TextStyle(color: Color.fromRGBO(206, 206, 206, 1)),),
                      value: false,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                      },
                      inactiveThumbColor: Color.fromRGBO(206, 206, 206, 1),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout,color: Colors.white,),
                title: Text('Logout'),
                textColor: Colors.white,
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Are sure you want to logout',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              try{
                                await GoogleSignIn().signOut();
                                await FacebookAuth.instance.logOut();
                                _auth.signOut()
                                    .then((value) => Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false)
                                );
                              }catch(e){
                                print("Error: ${e}");
                              }
                            },
                            child: Text('YES'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('NO'),
                          )
                        ],

                      )
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}