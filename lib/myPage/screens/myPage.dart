import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../authentication/screens/loginPage.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (User != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data == null) {
          return LoginPage();
        }
        else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("마이페이지", style: TextStyle(fontSize: 15)),
              backgroundColor: Colors.white,
            ),
            body: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - kBottomNavigationBarHeight,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text("Hello MyPage",)
            ),
          );
        }
      },
    );
  }
}
