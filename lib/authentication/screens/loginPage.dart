import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:small_talk/main/baseBottomNavigationBar.dart';
import 'package:small_talk/authentication/screens/resetPassword.dart';
import 'package:small_talk/authentication/screens/signupPage.dart';
import '../database/accountProvider.dart';
import 'emailNonVerified.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifier {
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
    Account();
    return Scaffold(
        backgroundColor: Colors.white,
        /// Prevent Keyboard Overflow
        resizeToAvoidBottomInset: false,
        //key: scaffoldKey,
        /// Full Screen
        body:SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            /// Blank of Top
            padding: EdgeInsetsDirectional.fromSTEB(10, 70, 10, 0),
            /// Background Image
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.60),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Logo Space
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /// Logo Image
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 100,
                      child: Image.asset(
                        'images/Logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '듀오 할래?',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          //loading: _loadingButton1,
                        )
                    )
                    ,
                    Container(
                      width: 120,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),

                /// Login Space
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  /// 입력창 + 비밀번호 재설정 공간
                  child: Form(
                    child: Column(
                      children: <Widget>[
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

                        /// Reset Password - Text Button
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const ResetPassword();
                                })
                            );
                          },
                          child: Text(
                            '비밀번호를 잊으셨나요?',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          //loading: _loadingButton3,
                        ),

                        /// login Button
                        SizedBox(
                          width: 200,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              signInWithEmail();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white70,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /// SignUp => New Route
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const SignUpPage();
                                    })
                                );
                              },
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              //loading: _loadingButton3,
                            ),
                            Text(
                              " / ",
                              style: TextStyle(
                                color: Color(0x98FFFFFF)
                              ),
                            ),
                            /// Guest
                            TextButton(
                              onPressed: () {
                                if(Account().useAsGuest() == true){
                                  print("성공");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return const BaseBottomNavigationBar();
                                      })
                                  );
                                }
                                else{
                                  print("실패");
                                  showSnackBarMessage("다시 어플을 실행해주세요.");
                                }

                              },
                              child: Text(
                                '가입 없이 이용',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0x98FFFFFF),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              //loading: _loadingButton3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                /// message for social account login
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                  child: Text(
                    'SNS 계정을 사용해보세요.',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0x98FFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                /// social account Login button
                Container(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      /// Google Login
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)
                            ),
                          ),
                          onPressed: signInWithGoogle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Image.asset(
                                "images/logo_Google.png",
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                              ),
                              Text(
                                "Google로 시작하기",
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )



    );
  }


  /// 기능부

  /// 이메일/비밀번호로 Firebase에 로그인
  Future<void> signInWithEmail() async {
    String result = await Account().signInWithEmail(_emailAddressController.text, _passwordController.text);
    if(result == "continue"){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const BaseBottomNavigationBar();
          })
      );
    }
    else if(result == "NonVerified"){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const EmailNonVerified();
          })
      );
    }
    else{
      showSnackBarMessage(result);
      clearPasswordTextForm();
      dispose();
    }
  }

  /// Function of Google Login
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// 안내 메세지 실행
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

  /// 비밀번호란 초기화
  void clearPasswordTextForm() {
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}