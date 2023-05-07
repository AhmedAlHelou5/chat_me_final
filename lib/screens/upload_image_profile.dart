import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../providers/auth_provider.dart';
import 'chat_screen.dart';
import 'login_screen.dart';

class UploadImageProfile extends StatefulWidget {
  const UploadImageProfile({super.key});


  @override
  State<UploadImageProfile> createState() => _UploadImageProfileState();
}

class _UploadImageProfileState extends State<UploadImageProfile> {
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

    String url = "";
  bool? _isConnected;



  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 50,maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    } else {
      print('No picked image');
    }
  }

  auth.UserCredential? authResult;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  uploadFile(File? file) async {
    try {
      final _auth = auth.FirebaseAuth.instance;
      final user = auth.FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      var currentUserId = user.uid;
      final response = await InternetAddress.lookup('www.google.com');
      try {
        if (response.isNotEmpty) {
          var imagefile = FirebaseStorage.instance
              .ref()
              .child('user_image')
              .child(currentUserId + '.jpg');
          UploadTask task = imagefile.putFile(file!);
          TaskSnapshot snapshot = await task;
          url = await snapshot.ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserId)
              .update({
            'image_url': url,
          });



            if (url != null && file != null) {
            Fluttertoast.showToast(
              msg: "Done Uploaded",
              textColor: Colors.red,
            );
          } else {
            Fluttertoast.showToast(
              msg: "Something went wrong",
              textColor: Colors.red,
            );
          }
        }
      } on Exception catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          textColor: Colors.red,
        );
      }
    } on SocketException catch (err) {
      setState(() {
        _isConnected = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Don’t Send because No Internet connection')));
      });
      if (kDebugMode) {
        print(err);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context,listen: false);
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Choose Your Image Profile"),
        actions: [
          Container(
            margin:const EdgeInsets.only(right: 15),
            child: DropdownButton(
              underline: Container(),
              icon: Icon(Icons.menu,
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 27),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),

              ],
              onChanged: (itemIdentifier) async {
                if (itemIdentifier == 'logout') {
                  await authProvider.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>LoginScreen()
                  ));
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [

          SizedBox(
            height: _height * 0.25,
          ),


          GestureDetector(
            onTap: (){},
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
            ),
          ),
          SizedBox(
            height: _height * 0.1,

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed:()=> _pickImage(ImageSource.camera),
                icon: Icon(Icons.photo_camera_outlined),
                label: Text(
                  'Add Image\nfrom Camera',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              TextButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(Icons.image_outlined),
                label: Text(
                  'Add Image\nfrom Gallery',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
          SizedBox(height: 40,),


          ElevatedButton(
            onPressed: () async {
              // print(_pickedImage);
                  // print({widget._pickedImage});
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => ChatScreen()));


                      uploadFile(_pickedImage!);
                      print(_pickedImage);

                  Fluttertoast.showToast(
                    msg: "Done",
                    textColor: Colors.red,
                  );

            },

            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                fixedSize: const Size(150, 50)),
            child: const Text(
                'Upload Image',
              style: TextStyle(fontSize: 18),
            ),
          ),



        ],
      ),
    );
  }

}
