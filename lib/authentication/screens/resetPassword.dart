import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Prevent Keyboard Overflow
      resizeToAvoidBottomInset: false,
      body: Text("비밀번호 재설정"),
    );
  }
}

