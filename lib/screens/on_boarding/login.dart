import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zunada/screens/on_boarding/register.dart';
import 'package:zunada/screens/on_boarding/verify_email.dart';
import '../../components/overlay_progress_bar.dart';
import '../../components/widget_constant.dart';
import '../../services/authentication.dart';
import '../home_page/home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Authentication _authentication = Authentication();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirm_password;
  bool _isObscure1 = true;
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
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: RichText(
                      text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome,\n',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign in to continue!',
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
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {

                      },
                        child: Text('Forget Password?',style: TextStyle(color: Colors.black),))
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        showSendingProgressBar();
                        await _authentication.signInWithEmail(
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
                    child: Text('Login',style: TextStyle(color: Colors.white)),
                    color: Colors.cyan,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await _authentication.signInWithGoogle(context)
                              .then((value) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
                          }).catchError((error) => print("Failed to add user: $error"));
                        },
                        icon: Icon(Icons.email_outlined,color: Colors.grey),
                        label: Text('Continue with Google',style: TextStyle(color: Colors.grey)),
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
                        label : Text('continue with Facebook',style: TextStyle(color: Colors.grey)),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Don\'t have an account? ',style: TextStyle(color: Colors.black),),
                      GestureDetector(
                        child: Text(
                            'SignUp',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                              color: Colors.blue
                            )
                        ),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
