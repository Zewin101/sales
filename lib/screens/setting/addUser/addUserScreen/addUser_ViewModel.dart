
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/login/loginScreen/login_ViewModel.dart';

import '../../../../shared/constants/constants.dart';
import '../../../login/model/my_user.dart';

class AddUser_ViewModel extends BaseViewModel<addUser_Navigator>{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  void Login_Account(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.loginSuccessfully);
      Login_ViewModel.allUser.add(email);
      print(Login_ViewModel.allUser);
      MyUser myUser= MyUser(id: credential.user!.uid, email: email);
      navigator!.hideLoading();
      navigator!.goToBack();
    } on FirebaseAuthException catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.wrongEmailOrPassword);
    } catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(e.toString());
    }
  }

}


abstract class addUser_Navigator extends BaseNavigator{
  goToBack();
}