import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../database/db.dart';
import '../database/post.dart'; // for the utf8.encode method

class WritePage extends StatefulWidget {
  WritePage({Key? key, required this.id}) : super(key: key);
  final String id;


  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String title = '';
  String text = '';
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        /// resizeToAvoidBottomInset : keyboard로 인한 overflow 방지
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("새 글 작성"),
          backgroundColor: Colors.amber,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(_context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: saveDB,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                maxLines: 1,
                onChanged: (String title) {
                  this.title = title;
                },
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                //obscureText: true,
                decoration: InputDecoration(
                  hintText: '글 제목을 적어주세요.',
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                maxLines: 8,
                onChanged: (String text) {
                  this.text = text;
                },
                //obscureText: true,
                decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: '본문 내용을 적어주세요.',
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> saveDB() async {
    DBHelper sd = DBHelper();

    var fido = Post(
      id: str2Sha512(DateTime.now().toString()), // String
      title: title,
      text: text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertPost(fido);

    print(await sd.posts());
    Navigator.pop(_context);
  }

  String str2Sha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
