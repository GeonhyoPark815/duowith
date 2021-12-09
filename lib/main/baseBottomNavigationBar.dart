import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/myPage/screens/myPage.dart';
import 'package:small_talk/authentication/screens/logout.dart';
import 'package:small_talk/main/screens/mainPage.dart';
import '../forum/screens/forumPage.dart';
import '../authentication/screens/loginPage.dart';

class BaseBottomNavigationBar extends StatefulWidget {
  const BaseBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _BaseBottomNavigationBarState createState() => _BaseBottomNavigationBarState();
}

class _BaseBottomNavigationBarState extends State<BaseBottomNavigationBar> {
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
      backgroundColor: Colors.grey,
      body:Center(
        child: _pages[_selectedIndex],
      ),

      /// 하단
      /// https://material.io/components/bottom-navigation/flutter#theming-a-bottom-nav-bar
      /// https://security-nanglam.tistory.com/484
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white70,
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
    /// 소식 및 광고 페이지
    const MainPage(),
    /// 게시판 페이지
    const ForumPage(),
    Container(
      child: Text("듀오 검색 or 전적검색 링크"),
    ),
    /// 마이페이지
    const MyPage()
  ];
}