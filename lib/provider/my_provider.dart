import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales/models/myUser.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';

import '../screens/login/model/my_user.dart';

class MyProvider extends ChangeNotifier {
  RodinaKidsUser? rodinaKidsUser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initMyUser();
    }
  }

  void initMyUser() async {
    rodinaKidsUser =
        await FirebaseUtils.readUserFromFirestore(firebaseUser?.uid ?? '');
  }
}
