import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/accountProvider.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: TextButton(
          child: Text("로그아웃"),
          onPressed: () {
            Account().signOut();
          },
        ),
      )
    );
  }
}
