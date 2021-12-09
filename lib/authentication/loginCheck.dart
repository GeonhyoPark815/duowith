import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main/baseBottomNavigationBar.dart';
import 'screens/loginPage.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.data == null) {
            return LoginPage();
          }
          else {
            return BaseBottomNavigationBar();
          }
        },
      ),
    );
  }
}
