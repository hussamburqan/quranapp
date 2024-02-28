import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quran/auth/IntroPage.dart';
import 'package:quran/page/home_page.dart';
import 'auth/singup.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
     const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('======> User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('======> User is signed in!');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.green,
        body: (FirebaseAuth.instance.currentUser != null)
            ? const HomePage()
            : IntroPage(),
      ),

      routes: {
        'signup' : (context) => const SignUp(),
        'login' : (context) => IntroPage(),
        'homepage' : (context) => const HomePage(),
        //'verifiedpage' : (context) => const PageVerified(),
    },
    );
  }
}
