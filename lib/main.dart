import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'small_talk',
      theme: ThemeData(
        /// 테마 속성을 'indigo'로 설정
        /// Material Colors 중에 지정
        /// https://points.tistory.com/65
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          subtitle1: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            fontSize:14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}