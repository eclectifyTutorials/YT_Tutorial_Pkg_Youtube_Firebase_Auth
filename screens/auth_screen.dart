
// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yt_pkg_firebase_core/global/global_colors.dart';
import 'package:yt_pkg_firebase_core/services/authentication.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key,}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _userSignedIn = false;
  final Authentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

    /// Events are fired when the following occurs:
    /// - Right after the listener has been registered.
    /// - When a user is signed in.
    /// - When the current user is signed out.
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() => _userSignedIn = false);
      } else {
        print('User is signed in!');
        setState(() => _userSignedIn = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Authentication"),
        // backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Text("Status: ${_userSignedIn? "Signed In" : "Signed Out"}"),
              SizedBox(height: 20,),
              TextField(
                controller: _emailController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              SizedBox(height: 20,),//spacing
              TextField(
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _signUpPressed,
                child: Text("Sign Up"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _signInPressed,
                child: Text("Sign In"),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _signOutPressed,
                child: Text("Sign Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUpPressed() async {
    _authentication.signUp(_emailController.text.trim(),
      _passwordController.text.trim(),);
  }

  void _signInPressed() async {
    _authentication.signIn(_emailController.text.trim(),
      _passwordController.text.trim(),);
  }

  void _signOutPressed() async {
    _authentication.signOut();
  }

}




