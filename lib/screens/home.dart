import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/database/post.dart';
import 'package:small_talk/screens/view.dart';
import 'package:small_talk/screens/write.dart';

import '../database/db.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// https://otrodevym.tistory.com/entry/flutter-06-AppBar에-메뉴-아이콘-추가하기
      appBar: AppBar(
        title: const Text("SmallTalk"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
            Expanded(child: postBuilder(context))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context, CupertinoPageRoute(builder: (context) => WritePage(id: '',))).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Post 불러오기
  Future<List<Post>> loadPost() async {
    DBHelper sd = DBHelper();
    return await sd.posts();
  }

  Widget postBuilder(BuildContext parentContext) {
    return FutureBuilder<List<Post>>(
      builder: (context, snap) {
        if (snap.data == null ||(snap.data as List).isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: const Text(
              '새로운 글을 추가해보세요!\n\n\n\n\n\n\n\n\n',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          itemCount: (snap.data as List).length,
          itemBuilder: (context, index) {
            Post post = snap.data![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    parentContext,
                    CupertinoPageRoute(
                        builder: (context) => ViewPage(id: post.id,)));
              },
              child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                  alignment: Alignment.center,
                  height: 110,
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Container(
                              height: 17,
                              child: Text(
                                /// user ID
                                '익명',
                                style: TextStyle(fontSize: 13),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Text(
                            post.createTime.split(':')[0] + ":" + post.createTime.split(':')[1] ,
                            style: TextStyle(fontSize: 11),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        post.text,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                            size: 15,
                          ),
                          Text(
                            " 100  ",
                            style: TextStyle(
                              fontSize: 10
                            ),
                          ),
                          Icon(
                            Icons.messenger_outline_outlined,
                            color: Colors.black,
                            size: 13,
                          ),
                          Text(
                            " 200  ",
                            style: TextStyle(
                                fontSize: 10
                            ),
                          ),
                        ],
                      )
                      /// 추후 좋아요 횟수 추가
                    ],
                  ),

              ),
            );
          },
        );
      },
      future: loadPost(),
    );
  }
}


