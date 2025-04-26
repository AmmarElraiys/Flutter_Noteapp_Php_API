import 'package:flutter/material.dart';
import 'package:notes_app_php/screens/auth/login_screen.dart';
import 'package:notes_app_php/screens/auth/signup_screen.dart';
import 'package:notes_app_php/screens/auth/success_screen.dart';
import 'package:notes_app_php/screens/home/add_notes_screen.dart';
import 'package:notes_app_php/screens/home/edit_notes_screen.dart';
import 'package:notes_app_php/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: sharedPreferences!.getString('id') == null ? "/" : "/home",
      routes: {
        "/": (context) => LoginScreen(),
        "/signup": (context) => SignupScreen(),
        "/home": (context) => HomeScreen(),
        "/success": (context) => SuccessScreen(),
        "/addnotes": (context) => AddNotesScreen(),
        "/editnotes": (context) => EditNotesScreen(),
      },
    );
  }
}
