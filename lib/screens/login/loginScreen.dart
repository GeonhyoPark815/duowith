import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late bool passwordVisibility;

  /// for Google Login
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
            width: MediaQuery.of(context).size.width,

            /// 하단 네비게이션바에 겹치지 않게 하기
            //height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: Image.asset(
                  /// Login 창 배경 사진 삽입
                  'assets/images/login_screen.png',
                ).image,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 60,
                      child: Image.asset(
                        'images/Logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    print('SignIn pressed ...');
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    //loading: _loadingButton1,
                                  )),
                              Container(
                                width: 90,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    print('SignUp pressed ...');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white60,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    //loading: _loadingButton1,
                                  )),
                              Container(
                                width: 90,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    /// email - TextField
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                      child: TextFormField(
                        controller: emailAddressController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0x98FFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Enter Your Email...',
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
                    ),

                    /// password - TextField
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: !passwordVisibility,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0x98FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: 'Enter Your Password...',
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
                              onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility,
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
                        )),
                    /// login Button
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: SizedBox(
                          width: 230,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Button-Login pressed ...');
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        //loading: _loadingButton2,
                        ),
                    /// forgot password - Text Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: TextButton(
                        onPressed: () {
                          print('Button-ForgotPassword pressed ...');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //loading: _loadingButton3,
                      ),
                    ),
                    /// message for social account login
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: Text(
                        'Or use a social account to login',
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0x98FFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    /// social account Login button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /// Google Login
                          RaisedButton(
                              elevation: 0.0,
                              color: Colors.lightBlueAccent,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
