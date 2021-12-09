import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

String _tempEmail = "";
String _tempPassword = "";

class Account with ChangeNotifier{
  late User? _user;
  RegExp emailFormat = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp passwordFormat = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');

  Account() {
    _prepareUser();
  }

  User getUser() {
    return _user!;
  }

  String getUserEmail() {
    return getUser().email!;
  }

  void setUser(User? value) {
    _user = value;
    notifyListeners();
  }

  // 최근 Firebase에 로그인한 사용자의 정보 획득
  _prepareUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null){
      setUser(currentUser);
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    setUser(null);
  }

  /// 사용자에게 인증 이메일 전송
  sendEmailForVerified() async {
    await getUser().sendEmailVerification();
    signOut();
  }

  /// 사용자에게 비밀번호 재설정 메일을 영어로 전송 시도
  sendPasswordResetEmailByEnglish() async {
    await FirebaseAuth.instance.setLanguageCode("en");
    sendPasswordResetEmail();
  }

  /// 사용자에게 비밀번호 재설정 메일을 한글로 전송 시도
  sendPasswordResetEmailByKorean() async {
    await FirebaseAuth.instance.setLanguageCode("ko");
    sendPasswordResetEmail();
  }

  /// 사용자에게 비밀번호 재설정 메일을 전송
  sendPasswordResetEmail() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: getUser().email!);
  }

  /// Firebase로부터 회원 탈퇴
  withdrawalAccount() async {
    await getUser().delete();
    setUser(null);
  }

  /// 이메일/비밀번호로 Firebase에 로그인
  Future<String> signInWithEmail(String _inputEmail, String _inputPassword) async {
    String _email = _inputEmail;
    String _password = _inputPassword;

    if(_email.isNotEmpty && _password.isNotEmpty){
      if (emailFormat.hasMatch(_email)){
        if (passwordFormat.hasMatch(_password)) {
          try {
            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
            if (userCredential.user != null && userCredential.user!.emailVerified) {
              setUser(userCredential.user!);
              return ("continue");
            }
            else{
              return ("NonVerified");
            }
          }
          on FirebaseAuthException catch (e) {
            /// Error : Non-User
            if(e.code == 'user-not-found'){
              return ("등록되지 않은 사용자입니다.\n이메일을 다시 확인해주세요.");
            }
            /// Other Error
            else{
              return ("다시 시도해주세요.");
              //clearPasswordTextForm();
            }
          }
        }
        else{
          /// Error : Wrong Password Format
          return ("비밀번호는 영문자, 특수문자, 숫자가 포함된\n 8자리 이상 15자리 이하입니다.");
          //clearPasswordTextForm();
        }
      }
      else{
        /// Error : Wrong Email Format
        return ("올바른 이메일 형식이 아닙니다.");
        //clearPasswordTextForm();
      }

    }
    else{
      /// Error : Empty Input
      return ("정보를 빠짐 없이 입력해주세요.");
      //clearPasswordTextForm();
    }

  }

  /// 이메일/비밀번호로 Firebase에 회원가입
  Future<String> signUpWithEmail(String _inputEmail, String _inputPassword, String _inputConfirmPassword) async {
    String _email = _inputEmail;
    String _password = _inputPassword;
    String _confirmPassword = _inputConfirmPassword;


    if(_email.isNotEmpty && _password.isNotEmpty && _confirmPassword.isNotEmpty){
      if(emailFormat.hasMatch(_email)){
        if(passwordFormat.hasMatch(_password)){
          if (_password == _confirmPassword){
            try{
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
              signOut();
              return ("이미 가입된 이메일입니다.");
            }
            on FirebaseAuthException catch (e) {
              /// NonRegisteredUser
              if(e.code == 'user-not-found'){
                saveTemp(_email, _inputPassword);
                return ("continue");
              }
              /// Other Error
              else{
                return ("이미 가입된 이메일입니다.");
                //clearPasswordTextForm();
              }
            }
            /*
            try{

              /// 가입 정보 업로드
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email, password: _password);
              /*
              /// 인증 이메일 발송
              userCredential.user?.sendEmailVerification();
              /// 새로운 계정 생성이 성공하였으므로 기존 계정이 있을 경우 로그아웃 시킴
              signOut();
              showSnackBarMessage("회원가입에 성공하셨습니다.\n인증을 위해 이메일을 확인해주세요.");
              setState(() {
                _emailAddressController.clear();
                clearPasswordTextForm();
              });

               */
              return ("continue");
            }
            on FirebaseAuthException catch (e) {
              /// Error : Already Registered User
              if (e.code == 'email-already-in-use') {
                return ('이미 사용중인 이메일입니다.');
              }
              else{
                return ("다시 시도해주세요.");
                //clearPasswordTextForm();
              }
            }

             */
          }
          else{
            /// Error : Fail to Confirm Password
            return ("비밀번호가 일치하지 않습니다.");
          }
        }
        else{
          /// Error : Wrong Password Format
          return ("비밀번호는 영문자, 특수문자, 숫자가 포함된\n 8자리 이상 15자리 이하입니다.");
        }
      }
      else{
        /// Error : Wrong Email Format
        return ("올바른 이메일 형식이 아닙니다.");
      }
    }
    else{
      /// Error : Empty Input
      return ("정보를 빠짐 없이 입력해주세요.");
    }
  }

  Future<bool> useAsGuest() async {
    try{
      signOut();
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      setUser(userCredential.user!);
      return true;
    }
    on FirebaseAuthException catch (e)  {
      return false;
    }
}


  saveTemp(String newEmail, String newPassword){
    _tempEmail = newEmail;
    _tempPassword = newPassword;
  }

  Future<bool> registerAccount() async {
    /// 가입 정보 업로드
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _tempEmail, password: _tempPassword);
    _tempEmail = "";
    _tempPassword = "";
    if(userCredential != null){
      return true;
    }
    else {
      signOut();
      return false;
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
}