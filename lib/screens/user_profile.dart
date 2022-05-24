import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zunada/components/widget_constant.dart';
import 'package:zunada/screens/zunda_artirst_form.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isEnable = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  String? _first_name;
  String? _last_name;
  String? _email;
  String? _gender;
  String? _phone_number;
  String? _country;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = _auth.currentUser;
    // user_profile();
  }
  Future<void> _refresh() {
    return Future.delayed(
        Duration(seconds: 5)
    );
  }
  void user_profile() async{
    await _firestore.collection('User')
        .doc(user!.uid)
        .get()
        .then((value){
      final profile = value.data();
      setState(() {
        _first_name = profile?['first_name'];
        _email = profile?['email'];
        _country = profile?['country'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        leading: Icon(Icons.arrow_back),
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          isEnable == true
              ? TextButton(
              onPressed: () {
                setState(() {
                  isEnable = false;
                });
              },
              child: Text('Save',style: TextStyle(color: Colors.white),))
              : IconButton(
              onPressed: () {
                setState(() {
                  isEnable = true;
                });
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text("Document does not exist"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('User Name',style: TextStyle(fontSize: 18),),
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage('assets/images/tems.jpg'),
                          ),
                          Positioned(
                            top: 0,
                            right: 10,
                            child: Icon(Icons.add_circle,color: Colors.white),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
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
                            width: 200,
                            alignment: Alignment.center,
                            height: 40,
                            child: Text('Go to Premium',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Profile
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Profile',style: TextStyle(fontSize: 18),),
                          ),
                          //First name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue: snapshot.data!['first_name'] ?? '',
                              decoration: kUserTextDecoration(hint: 'First Name'),
                              enabled: isEnable,
                              style: const TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) => _first_name = value,
                            ),
                          ),
                          //Last name
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: kUserTextDecoration(hint: 'Last Name'),
                              enabled: isEnable,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) => _last_name = value,
                            ),
                          ),
                          //Gender
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: kUserTextDecoration(hint: 'Gender'),
                              dropdownColor: Color.fromRGBO(27, 32, 57, 1),
                              items: <String>['Male','Female']
                                  .map((value){
                                return DropdownMenuItem<String>(
                                  child: Text(value,style: TextStyle(color: Colors.white)),
                                  value: value,
                                );
                              }).toList(),
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              onChanged: !isEnable ? null : (String? value) => _gender = value,
                            ),
                          ),
                          //Phine number
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue: snapshot.data!['phone_number'],
                              decoration: kUserTextDecoration(hint: 'Phone Number'),
                              enabled: isEnable,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) => _phone_number = value,
                            ),
                          ),
                          //Email
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              // initialValue: data!['email'],
                              decoration: kUserTextDecoration(hint: 'Email Address'),
                              enabled: false,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),

                          //Account
                          Text('Account',style: TextStyle(fontSize: 18),),
                          ListTile(
                            title: Text('I am an artist'),
                            textColor: Colors.white,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ZundaArtistForm(),));
                            },
                          ),
                          ListTile(
                            title: Text('Change Password'),
                            textColor: Colors.white,
                            onTap: (){

                            },
                          ),
                          ListTile(
                            title: Text('Help'),
                            textColor: Colors.white,
                            onTap: (){

                            },
                          ),
                          ListTile(
                            title: Text('Feedback'),
                            textColor: Colors.white,
                            onTap: (){

                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
