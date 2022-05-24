import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zunada/components/widget_constant.dart';
import 'package:zunada/screens/home_page/home_page.dart';
import 'package:zunada/screens/on_boarding/verify_email.dart';
import 'package:zunada/services/authentication.dart';

import '../../components/overlay_progress_bar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // const RegisterScreen({Key? key}) : super(key: key);
   final Authentication _authentication = Authentication();
   final _formKey = GlobalKey<FormState>();
   FirebaseAuth _auth = FirebaseAuth.instance;
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
   String? email;
   String? password;
   String? username;
   String? confirm_password;
   bool _isObscure1 = true;
   bool _isObscure2 = true;
   OverlayProgressBar? _sendingMsgProgressBar;

   @override
   void initState() {
     super.initState();
     _sendingMsgProgressBar = OverlayProgressBar();
   }

   @override
   void dispose() {
     _sendingMsgProgressBar!.hide();
     super.dispose();
   }

   void showSendingProgressBar() {
     _sendingMsgProgressBar!.show(context);
   }
   void hideSendingProgressBar() {
     _sendingMsgProgressBar!.hide();
   }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Create Account,\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up to get Started!',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                              fontSize: 24,
                            ),
                          ),
                        ]
                      )
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: kTextDecoration(hint: 'Username'),
                    style: TextStyle(
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => username = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: kTextDecoration(hint: 'Email Address'),
                    style: TextStyle(
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) => email = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: kTextDecoration(hint: 'Password',suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure1 ? Icons.visibility_off : Icons.visibility,color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _isObscure1 = !_isObscure1;
                        });
                      },
                    )),
                    obscureText: _isObscure1,
                    style: const TextStyle(
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: kTextDecoration(hint: 'Confirm Password',suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure2 ? Icons.visibility_off : Icons.visibility,color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                    ),),
                    obscureText: _isObscure2,
                    style: TextStyle(
                        color: Colors.black
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      else if(password != value){
                        return 'Password does not match';
                      }
                      return null;
                    },
                    onChanged: (value) => confirm_password = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        showSendingProgressBar();
                       dynamic result = await _authentication.signUpWithEmail(
                            username: username!,
                            email: email!,
                            password: password!,
                            context: context);
                        if(FirebaseAuth.instance.currentUser != null){
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => VerifyEmailPage(),), (route) => false);
                        }
                        hideSendingProgressBar();
                      }
                    },
                    child: Text('Create an account',style: TextStyle(color: Colors.white)),
                    color: Colors.cyan,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _authentication.signInWithGoogle(context)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                        }).catchError((error) => print("Failed to add user: $error"));;
                      },
                      icon: Icon(Icons.email_outlined,color: Colors.grey),
                      label: Text('Connect with Google',style: TextStyle(color: Colors.grey)),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,

                      ),
                      // textColor: Colors.white,
                      // color: Colors.red,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _authentication.signInWithFacebook();
                      },
                      icon: Icon(Icons.facebook,color: Colors.grey),
                      label : Text('Connect with Facebook',style: TextStyle(color: Colors.grey)),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

