import 'package:flutter/material.dart';

import '../database/db.dart';
import '../database/post.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        appBar: AppBar(
          title: const Text("SmallTalk"),
          backgroundColor: Colors.amber,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.message_outlined),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(padding: EdgeInsets.all(20), child: loadBuilder()));
  }

  Future<List<Post>>? loadPost(String id) async {
    DBHelper sd = DBHelper();
    return await sd.findPost(id);
  }

  loadBuilder() {
    return FutureBuilder<List<Post>>(
      future: loadPost(widget.id),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if ((snapshot.data as List).isEmpty) {
          return Container(child: const Text("데이터를 불러올 수 없습니다."));
        } else {
          Post post = snapshot.data![0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 70,
                child: SingleChildScrollView(
                  child: Text(
                    post.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Text(
                "최초 작성 시간: " + post.createTime.split('.')[0],
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.end,
              ),
              Text(
                "최근 수정 시간: " + post.editTime.split('.')[0],
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.end,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                      post.text,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
