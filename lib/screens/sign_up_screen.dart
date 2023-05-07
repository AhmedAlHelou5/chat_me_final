import 'dart:io';
import 'package:chat_me_final/screens/upload_image_profile.dart';
import 'package:chat_me_final/services/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../widgets/edit_text_login_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _userEmail;
  String? _confirm;
  String? _userPassword;
  File? _userImageFile;

  void _pickedImage(File? image) {
    _userImageFile = image;
  }

      auth.UserCredential? authResult;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;


  late void Function(
    String? email,
    String? password,
    String? userName,
      File? image,
      BuildContext ctx,

  ) submitFn;

  Future<void> _trySubmit() async {
    var isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();



    if (isValid) {
      _formKey.currentState!.save();
      _formKey.currentState!.validate();
      submitFn(
        _userEmail!,
        _userPassword!,
        _confirm!,
          _userImageFile!,
        context
      );
    }
    print(isValid);
  }





  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  TextEditingController _ConfirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // const SizedBox(height: 50.0),
               SizedBox(
                height: _height * 0.09,
              ),

              Image.asset(AssetsManager.logoNewPng,height: 200,width: 300,),


              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),

              EditTextLogin(
                label: 'Email',
                keyvalue: 'email',
                hint: 'Enter Email',
                icon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                validator: (value) {
                  if ((value != null && value.contains('@'))) {
                    return 'Do not use the @ char.';
                  } else {
                    return null;
                  }
                },
                show: false,
                textSaved: _userEmail,
                UserNameController: _EmailController,
              ),

              EditTextLogin(
                label: 'Password',
                keyvalue: 'password',
                hint: 'Enter Password',
                icon: const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                show: true,
                textSaved: _userPassword,
                UserNameController: _PasswordController,
              ),
              EditTextLogin(
                label: 'Confirm Password',
                keyvalue: 'confirm',
                hint: 'Enter Confirm Password',
                icon: const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                show: true,
                textSaved: _confirm,
                UserNameController: _ConfirmPasswordController,
              ),
              const SizedBox(
                height: 40,
              ),

              ElevatedButton(
                onPressed: () async {
      // print(_pickedImage);
      try {
        if (_PasswordController.text == _ConfirmPasswordController.text &&
            _PasswordController.text.length >= 6) {
          final credential =
              await _firebaseAuth.createUserWithEmailAndPassword(
              email: _EmailController.text,
              password: _PasswordController.text);
          // print({widget._pickedImage});
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => UploadImageProfile()));

          await FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .set({
            'email': _EmailController.text,
            'password': _PasswordController.text,
          });


          print('_EmailController.text :   ${_EmailController.text}');
          print(
              '_PasswordController.text :   ${_PasswordController
                  .text}');

          Fluttertoast.showToast(
            msg: "Done",
            textColor: Colors.red,
          );
        }  else{
          Fluttertoast.showToast(
            msg: "Confirm Password error ",
            textColor: Colors.red,
          );

        }
      } on PlatformException catch (e) {
        var message = 'An error occurred, pelase check your credentials!';
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        } else if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        }
      } catch (err) {
        print(err);
      }
    },

                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    fixedSize: const Size(100, 50)),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 15.0),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>LoginScreen()
                  ));

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I already have an account ?',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 5.0),
                    Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
