import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/authentication/screens/loginPage.dart';

import '../database/account.dart';

class EmailNonVerified extends StatefulWidget {
  const EmailNonVerified({Key? key}) : super(key: key);

  @override
  _EmailNonVerifiedState createState() => _EmailNonVerifiedState();
}

class _EmailNonVerifiedState extends State<EmailNonVerified> with ChangeNotifier {
  String inputEmail = Account().getUserEmail();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(.60),
        elevation: 0.0,
        title: Text("이메일 인증",
          style: TextStyle(
              fontSize: 16
          ),),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          IconButton(
              onPressed:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    })
                );
              },
              icon: Icon(Icons.clear_outlined))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        color: Colors.blueGrey.withOpacity(.60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("가입된 이메일 : $inputEmail"),
            Text("이메일을 확인하여 이메일 인증을 완료해주세요.",
            textAlign: TextAlign.center,),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  await Account().sendEmailForVerified();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      })
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white70,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)))),
                child: Text(
                  '인증 이메일 다시 받기',
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
