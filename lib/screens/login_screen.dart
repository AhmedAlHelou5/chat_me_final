import 'package:chat_me_final/screens/chat_screen.dart';
import 'package:chat_me_final/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/edit_text_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _userEmail;
  String? _userPassword;
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            SizedBox(
              height: _height * 0.1,
            ),
            Image.asset(
              AssetsManager.logoNewPng,
              width: 250,
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            EditTextLogin(
              label: 'Email',
              keyvalue: 'email',
              hint: 'Enter Email',
              icon: const Icon(Icons.email, color: Colors.grey),
              validator: (value) {
                if ((value != null && value.contains('@'))) {
                  return 'Do not use the @ char.';
                } else {
                  return null;
                }
              },
              show: false,
              textSaved: _userEmail, UserNameController: _EmailController,
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
              textSaved: _userPassword, UserNameController: _PasswordController,
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: ()async {
               await authProvider.SignInWithEmailAndPassword(_EmailController.text, _PasswordController.text);

               Navigator.of(context).pushReplacement(
                   MaterialPageRoute(
                       builder: (context) =>  ChatScreen()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, fixedSize: const Size(100, 50)),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen()));

              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 5.0),
                  Text(
                    'Create an account',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
