import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:small_talk/database/post.dart';

import 'login/loginScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      //key: scaffoldKey,
      backgroundColor: Colors.amberAccent,
      body: Center(
              child: _pages[_selectedIndex],
        ),


      /// 하단
      /// https://material.io/components/bottom-navigation/flutter#theming-a-bottom-nav-bar
      /// https://security-nanglam.tistory.com/484

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amber,
        //Bar의 배경색
        selectedItemColor: Colors.black,
        //선택된 아이템의 색상
        unselectedItemColor: Colors.black.withOpacity(.60),
        //선택 안된 아이템의 색상
        selectedFontSize: 11,
        //선택된 아이템의 폰트사이즈
        unselectedFontSize: 10,
        //선택 안된 아이템의 폰트사이즈
        currentIndex: _selectedIndex,
        //현재 선택된 Index
        onTap: (int index) {
          //눌렀을 경우 어떻게 행동할지
          setState(() {
            //setState()를 추가하여 인덱스를 누를때마다 빌드를 다시함
            _selectedIndex = index; //index는 처음 아이템 부터 0, 1, 2, 3
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: "Menu",
            icon: Icon(Icons.menu_outlined),
          ),
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(Icons.message_outlined),
          ),
          BottomNavigationBarItem(
            label: "MyPage",
            icon: Icon(Icons.account_box_outlined),
          ),
        ],
      ),
    );
  }

  /// https://fre2-dom.tistory.com/243
  final List _pages = [
    const Home(),
    const LoginScreen(),
    const Text(
      'Places',
      style: TextStyle(fontSize: 30,),
    ),
    const Text(
      'News',
      style: TextStyle(fontSize: 30,),
    ),
  ];
}