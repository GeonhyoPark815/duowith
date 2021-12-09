import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/main/alerts.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "듀오링",
            style: TextStyle(
                fontSize: 15
            )
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const AlertsPage();
                  })
              );
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "images/startPage/startPageScreen.jpg",
            )
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(10, 70, 10, 0),
              child: Text(
                "혼자 게임하기 심심하셨죠?\n지금 바로 듀오를 구해보세요!\n"
                    "메인 화면에 각 게임 게시판 연결 링크 및 전적 검색 링크"
              ),
            )
          ],
        ),
      ),
    );
  }
}
