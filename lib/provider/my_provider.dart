

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../screens/login/model/my_user.dart';


class MyProvider extends ChangeNotifier{
MyUser? myUser;
User? firebaseUser;
MyProvider(){
firebaseUser=FirebaseAuth.instance.currentUser;

}
void intMyUser()async{
// myUser=await
}

}