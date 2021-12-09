import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/account.dart';
import 'loginPage.dart';

class PrivacyConsentPage extends StatefulWidget {
  const PrivacyConsentPage({Key? key}) : super(key: key);

  @override
  _PrivacyConsentPageState createState() => _PrivacyConsentPageState();
}

class _PrivacyConsentPageState extends State<PrivacyConsentPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("회원가입",
          style: TextStyle(
              fontSize: 16
          ),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                        "개인 정보 동의"
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        )
                      ),
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 100,
                      child: SingleChildScrollView(
                        child: Text(
                            "내용1\n내용2\n내용3\n내용4\n내용5\n내용6\n내용7\n내용8\n내용9\n내용10\n내용11\n내용12\n"
                        ),
                      ),
                    ),
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value){
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                height: 30,
                child: ElevatedButton(
                  onPressed: () async {
                    if(await Account().registerAccount() == true){
                      await Account().sendEmailForVerified();
                      showSnackBarMessage("이메일을 확인해서 인증을 완료해주세요.");
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          })
                      );
                    }

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white70,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)))),
                  child: Text(
                    '회원가입',
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
      )
    );
  }

  void showSnackBarMessage(snackBarMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          snackBarMessage,
          textAlign: TextAlign.center,
        ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          backgroundColor: Colors.blue,
        )
    );
  }
}
