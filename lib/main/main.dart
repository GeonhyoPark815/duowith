import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/authentication/database/accountProvider.dart';
import '../authentication/loginCheck.dart';
import 'screens/splashScreen.dart';

void main() async{
  /// 비동기 방식의 Firebase.initializeApp() 매서드를 실행하기 위하여
  /// Flutter 코어 엔진의 초기화를 수행
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Account())
        ],
        child: const MyApp()),
      );
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
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginCheck();
            }
            return SplashScreen();
          },
        ),
      );
  }
}