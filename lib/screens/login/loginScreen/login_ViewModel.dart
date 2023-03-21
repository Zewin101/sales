
import 'package:flutter/cupertino.dart';
import 'package:sales/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';
import '../../../models/myUser.dart';
import '../../../shared/constants/constants.dart';
import '../model/my_user.dart';

class Login_ViewModel extends BaseViewModel<Login_Navigtor> {
 // static List<String>allUser=['No User','zewin@2023.com'];
 List<RodinaKidsUser>allUsers=[];


 readAllUser()async{
   await FirebaseUtils.readAllUserFromFirestore().then((value) {

   });
 }

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  void Login_Account(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.loginSuccessfully);
     MyUser myUser= MyUser(id: credential.user!.uid, email: email);
     navigator!.hideLoading();
     navigator!.goToHome(myUser);
    } on FirebaseAuthException catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.wrongEmailOrPassword);
    } catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(e.toString());
    }
  }

}
abstract class Login_Navigtor extends BaseNavigator{
  void goToHome(MyUser myUser);
}