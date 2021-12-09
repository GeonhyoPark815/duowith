import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/authentication/screens/privacyConsent.dart';
import '../database/account.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ChangeNotifier {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool passwordVisibility = false;
  late User? _user; // Firebase에 로그인 된 사용자
  RegExp emailFormat = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp passwordFormat = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /// Prevent Keyboard Overflow
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(.60),
        elevation: 0.0,
        title: Text("회원가입",
        style: TextStyle(
          fontSize: 16
        ),),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          IconButton(
              onPressed:() {
                Account().withdrawalAccount();
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
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsetsDirectional.fromSTEB(10, 70, 10, 0),
            /// Background Image
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.60),
            ),
            child:Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// Logo space
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 60,
                  child: Image.asset(
                    'images/Logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                /// SignUp Textforms
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  height: 300,
                  width: MediaQuery.of(context)
                      .size
                      .width - 40,
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ///
                            ],
                          ),
                        ),

                        /// email - TextField
                        TextFormField(
                          controller: _emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: '이메일 주소',
                            labelStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0x98FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: '이메일 주소를 입력해주세요.',
                            hintStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0x98FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white10,
                            contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          ),
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        /// Space
                        SizedBox(
                          height: 8,
                        ),

                        /// password - TextField
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !passwordVisibility,
                          decoration: InputDecoration(
                            labelText: '비밀번호',
                            labelStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0x98FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            hintMaxLines: 1,
                            hintText: "비밀번호를 입력해주세요.",
                            hintStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0x98FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white10,
                            contentPadding:
                            EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            suffixIcon: InkWell(
                              onTap: () =>
                                  setState(
                                        () =>
                                    passwordVisibility = !passwordVisibility,
                                  ),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Color(0x98FFFFFF),
                                size: 20,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        /// Space
                        SizedBox(
                          height: 8,
                        ),

                        /// confirm password - TextField
                        Container(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: '비밀번호 확인',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0x98FFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: '비밀번호를 다시 한 번 입력해주세요.',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0x98FFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white10,
                                  contentPadding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                  suffixIcon: InkWell(
                                    onTap: () =>
                                        setState(
                                              () =>
                                          passwordVisibility =
                                          !passwordVisibility,
                                        ),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0x98FFFFFF),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "특수문자, 영문자, 숫자를 최소 1개 포함하여\n8자 이상 15자 이내로 비밀번호를 입력해주세요.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        /// SignUp TextButton
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              signUpWithEmail();
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
              ],
            )
        ),
      ),
    );
  }

  /// 기능부
  /// 이메일/비밀번호로 Firebase에 회원가입
  Future<void> signUpWithEmail() async {
    String result = await Account().signUpWithEmail(_emailAddressController.text, _passwordController.text, _confirmPasswordController.text);
    if(result == "continue"){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const PrivacyConsentPage();
          })
      );
    }
    else{
      showSnackBarMessage(result);
      clearPasswordTextForm();
      dispose();
    }
  }

  /// 안내 메세지 실행
  void showSnackBarMessage(snackBarMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          snackBarMessage,
          textAlign: TextAlign.center,
        ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          backgroundColor: Colors.red,
        )
    );
  }

  /// 비밀번호란 초기화
  void clearPasswordTextForm() {
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}
