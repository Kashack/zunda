import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zunada/screens/home_page/home_page.dart';

class Authentication{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // CollectionReference? _students;
  Future signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try{
      _auth.signInWithCredential(credential)
          .then((value){
        if (value != null){
          if(value.additionalUserInfo!.isNewUser){
            _firestore.collection('users')
                .doc(_auth.currentUser!.uid)
                .set({
              'first_name' : googleUser!.displayName,
              'last_name' : googleUser.displayName,
              'email': googleUser.email,
              'profileImage':googleUser.photoUrl
            });
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign in with different social auth')));
      }
    }
  }
  Future signInWithFacebook() async {
    final facebookAuth = FacebookAuth.instance;
    // Trigger the sign-in flow
    final LoginResult loginResult = await facebookAuth.login(
      permissions: ['public_profile', 'email', 'pages_show_list', 'pages_messaging', 'pages_manage_metadata'],
    );
    // final userData = await facebookAuth.getUserData(
    //   fields: "name,email,picture.width(200),gender,link",
    // );
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
   _auth.signInWithCredential(facebookAuthCredential)
       .then((value){
     if (value != null){
       // if(value.additionalUserInfo!.isNewUser ){
       //   _firestore.collection('users')
       //       .doc(_auth.currentUser!.uid).collection('profile')
       //       .add({
       //     'username' : userData['name'],
       //     'email': userData['email'],
       //     'verify': true,
       //     'profileImage':userData['picture']
       //   });
       // }
     }
   });

  }
  Future signUpWithEmail({required String username,required String email,
     required String password,required BuildContext context}) async{
    try{
      await _auth.
      createUserWithEmailAndPassword(email: email, password: password)
          .then((value){
            if (value != null){
              try{
                _firestore.collection('users')
                    .doc(_auth.currentUser!.uid)
                    .set({
                  'username' : username,
                  'email':email,
                });
              }on FirebaseException catch (e){
                if(e.code == "network-request-failed"){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Network error')));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.code}')));
                }
              }
            }
          });
    } on FirebaseAuthException catch (e){
      if(e.code == "network-request-failed"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Network error')));
      }else if(e.code == "email-already-in-use"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already in use')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }
  }
  Future signInWithEmail({required String email, required String password,required BuildContext context}) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      if(e.code == "network-request-failed"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Network error')));
      }else if(e.code == "email-already-in-use"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email already in use')));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }
  }

}