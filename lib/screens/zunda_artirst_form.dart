import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zunada/components/widget_constant.dart';

class ZundaArtistForm extends StatefulWidget {
  @override
  State<ZundaArtistForm> createState() => _ZundaArtistFormState();
}

class _ZundaArtistFormState extends State<ZundaArtistForm> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  File? file;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _artistname;
  String? _nationality;
  String? _country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 32, 57, 1),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color.fromRGBO(27, 32, 57, 1),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('assets/icons/logo_home.svg'),
        ),
        title: Text('Account'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              //artist
              Text(
                'Artist Name',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration : kArtistFormTextDecoration(hint: 'Enter Artist name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => _artistname = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Your Contact Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              //First name
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'First Name',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration : kArtistFormTextDecoration(hint: 'Your First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => _firstname = value,
                ),
              ),
              //Surname
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Last Name',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration : kArtistFormTextDecoration(hint: 'Your Surname'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => _lastname = value,
                ),
              ),
              //email
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              //nationality
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Nationality',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration : kArtistFormTextDecoration(hint: 'Nigerian,American,British etc...'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => _nationality = value,
                ),
              ),
              //Country
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Country',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration : kArtistFormTextDecoration(hint: 'Enter Your Country'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => _country = value,

                ),
              ),
              //media
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Upload a screenshot for your media page',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color.fromRGBO(134, 146, 166, 1),width: 1,style: BorderStyle.solid),
                  ),
                  child: file != null ?
                  Image.file(file!,fit: BoxFit.contain,): Icon(Icons.camera_alt)
                ),
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);
                  if(result != null){
                    setState(() {
                      file = File(result.files.single.path!);
                    });
                  }
                },
              ),
              MaterialButton(
                color: Color.fromRGBO(37, 37, 40, 1),
                child: Text('Submit',style: TextStyle(color: Colors.white),),
                height: 40,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color.fromRGBO(134, 146, 166, 1),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8)
                ),
                onPressed: () {
                  if(_formKey.currentState!.validate()){

                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
