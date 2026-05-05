import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sugarcheck/Initail%20login%20Module/ForgotPasswordPage.dart';
import 'package:sugarcheck/Initail%20login%20Module/Login.Page.dart';
import 'package:sugarcheck/Initail%20login%20Module/create%20your%20accout.dart';
import 'package:sugarcheck/Initail%20login%20Module/home_page.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SugarCheck',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return const HomePage();
          return const LoginPage();
        },
      ),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}