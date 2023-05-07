import 'package:chat_me_final/providers/auth_provider.dart';
import 'package:chat_me_final/providers/chats_provider.dart';
import 'package:chat_me_final/providers/models_provider.dart';
import 'package:chat_me_final/screens/chat_screen.dart';
import 'package:chat_me_final/screens/login_screen.dart';
import 'package:chat_me_final/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  Future checkLogin(BuildContext context)async {
    if ( FirebaseAuth.instance.currentUser == null) {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
    }

  }






  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=>ModelsProvider()),
        ChangeNotifierProvider(create:(_)=>ChatProvider()),
        ChangeNotifierProvider(create:(_)=>AuthProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor
          ),
          primarySwatch: Colors.blue,
        ),
        home:SplashScreen()
      ),
    );
  }
}

