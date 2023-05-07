import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier{
  auth.UserCredential? authResult;

  final auth.FirebaseAuth  _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user,String password){
    if(user == null){
      return null;
    }
    return User(email: user.email, password:password,  image: user.photoURL);
  }

  // Stream<User?>? get user{
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }

  Future<User?> SignInWithEmailAndPassword(
      String email,String password)async{
    final credential =await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(credential.user, password);

  }
  Future<User?> createUserWithEmailAndPassword(
      String? email,String? password,File? image)async{
    final credential=await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
    print('Signed up');

    final ref = await FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('${credential.user!.uid}.jpg');

    await ref.putFile(image!);

    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(authResult!.user!.uid)
        .set({
      'email': email,
      'password': password,
      'image_url': url,
      'userId':authResult!.user!.uid,
    });

    return _userFromFirebase(credential.user, password);

  }

  Future<void> signOut()async{
    return await _firebaseAuth.signOut();

  }


}