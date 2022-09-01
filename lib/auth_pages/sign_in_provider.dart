import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInProvider = ChangeNotifierProvider((ref) => AuthViewModelProvider());

class AuthViewModelProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  String _email = " ";
  String get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }


  String _password = " ";
  String get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _confirmPassword = " ";
  String get confirmPassowrd => _confirmPassword;
  set conirmPassword(String passwordValue) {
    _confirmPassword = passwordValue;
    notifyListeners();
  }

  bool _obscurePassword = false;
  bool get obscurePassword=>_obscurePassword;
  set obscurePassword(bool value){
    _obscurePassword=value;
    notifyListeners();
  }

  bool _obscureConfirmPassword = false;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  set obscureConfirmPassword(bool value){
    _obscureConfirmPassword = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  String? emailValidator(String email) {
    const String format =
       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    return !RegExp(format).hasMatch(email) ? "Enter Valid Email" : null;
  }

  Future<void> logIn() async {
    loading=true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      loading = false;
    }on FirebaseAuthException catch (e) {
      loading = false;
      if(e.code=="wrong-password"){
        return Future.error("Password is wrong");
      }else if(e.code=="user-not-found"){
        return Future.error("Can't find User");
      } else {
        return Future.error(e.message??"");
      }
    }catch(e) {
      if(kDebugMode){
        print(e);
      }
    }
  }

  Future<void> signUp() async {
       loading=true;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      
      );
      loading = false;
    }on FirebaseAuthException catch (e) {
      loading = false;
      if(e.code =="weak-password"){
        return Future.error("Enter a Strong Password");
      }else {
        return Future.error(e.message??"");
      }
    }catch(e) {
      if(kDebugMode){
        print(e);
      }
    }
  }
}
