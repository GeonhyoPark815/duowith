/// https://velog.io/@chb1828/첫-로딩화면-구축하기Splash-화면

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../forFirebase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.push(
        context,
        // 원래는 로그인 화면을 위한 ForFireBase()로 이동
        MaterialPageRoute(builder: (context) => ForFirebase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.deepOrange,
      alignment: Alignment.center,
      child: Text(
        "듀오\n구함",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
      /*
      decoration: BoxDecoration(
        image: DecorationImage(
          /// Splash Screen을 구성할 이미지를 저장해주세요.
            image: AssetImage('images/splash.jpg'), fit: BoxFit.cover),
      ),

       */
    );
  }
}
