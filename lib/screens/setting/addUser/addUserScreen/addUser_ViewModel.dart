import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sales/base.dart';
import 'package:sales/models/myUser.dart';
import 'package:sales/screens/login/loginScreen/login_ViewModel.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';

import '../../../../shared/constants/constants.dart';
import '../../../login/model/my_user.dart';

class AddUser_ViewModel extends BaseViewModel<addUser_Navigator> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  void createNewUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator!.hideLoading();
      navigator!.showMessage(FirebaseError.userCreated);
      RodinaKidsUser rodinaKidsUser = RodinaKidsUser(
          id: credential.user!.uid, name: name, phone: phone, email: email);
      await FirebaseUtils.addRodinaKidsUserFirestore(rodinaKidsUser)
          .then((value) {
        navigator!.hideLoading();
        navigator!.goToBack(rodinaKidsUser);
        emailController.clear();
        passwordController.clear();
        nameController.clear();
        phoneController.clear();

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakPassword) {
        navigator!.hideLoading();
        navigator!.showMessage(FirebaseError.passwordWeak);
      } else if (e.code == FirebaseError.emailAlreadyInUse) {
        navigator!.hideLoading();
        navigator!.showMessage(FirebaseError.existsEmail);

      }
    } catch (e) {
      navigator!.hideLoading();
      navigator!.showMessage(e.toString());
    }
  }
}

abstract class addUser_Navigator extends BaseNavigator {
  void goToBack(rodinaKidsUser);
}
