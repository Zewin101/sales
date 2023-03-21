import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/generated/assets.dart';
import 'package:sales/models/myUser.dart';
import 'package:sales/screens/login/loginScreen/login_ViewModel.dart';
import 'package:sales/shared/network/remote/firebase_Utils.dart';
import 'package:sales/styles/colors.dart';

import '../../../layout/home_layout/home_layout/home_layout.dart';
import '../../../shared/componant/componants.dart';
import '../model/my_user.dart';

class Login_View extends StatefulWidget {
  static const String routeName = 'login_view';

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends BaseView<Login_View, Login_ViewModel>
    implements Login_Navigtor {
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.readAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Image.asset(
          Assets.imageBack,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Rodina Kids',
              style: Theme.of(context).textTheme.headline1,
            ),
            actions: [
            IconButton(onPressed: (){
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Exit',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  FirebaseAuth.instance.signOut();
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }

                 
                },
              ).show();
            }, icon:   Icon(Icons.logout))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.25,
                        backgroundImage: const AssetImage(
                          Assets.imageLogo,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        cursorColor: Colors.redAccent,
                        onTap: () async {
                          await ShowBottomSheet();

                          setState(() {});
                        },
                        controller: viewModel.nameController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          labelText: 'User',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: RODINACOLOR,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: RODINACOLOR,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == '') {
                            return 'Enter password';
                          }
                          return null;
                        },
                        controller: viewModel.passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPassword,
                        decoration: InputDecoration(
                          labelText: 'password',
                          prefixIcon: isPassword
                              ? const Icon(Icons.lock)
                              : const Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            onPressed: () {
                              isPassword = !isPassword;
                              setState(() {});
                            },
                            icon: isPassword
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: RODINACOLOR),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: RODINACOLOR),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .07,
                        child: ElevatedButton(
                            onPressed: () {
                              LoginAccount();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        RODINACOLOR),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  // side: BorderSide(color: CHATCOLOR)
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Login",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Icon(Icons.double_arrow),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void LoginAccount() {
    if (formKey.currentState!.validate()) {
      viewModel.Login_Account(
          viewModel.emailController.text, viewModel.passwordController.text);
    }
  }

  @override
  Login_ViewModel initViewModel() {
    return Login_ViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  Future ShowBottomSheet() async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.35,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<QuerySnapshot<RodinaKidsUser>>(
                  future: FirebaseUtils.readAllUserFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasError){
                      return Text( 'Error ${snapshot.error}' );
                    }
                    var allUser =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    print(allUser);
                    return ListView.builder(
                      itemCount: allUser?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: index.isOdd ? RODINACOLOR2 : RODINACOLOR3,
                          margin: EdgeInsets.symmetric(vertical: 6),
                          height: 45,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              viewModel.emailController.text =
                                  allUser[index].email;
                              viewModel.nameController.text =
                                  allUser[index].name;
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            readOnly: true,
                            controller: TextEditingController(
                                text: allUser![index].name),
                            decoration: InputDecoration(
                              prefixIcon: Radio(
                                  value: allUser![index].name,
                                  groupValue: allUser,
                                  onChanged: (value) {
                                    allUser![index].name = value.toString();
                                  }),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: RODINACOLOR,
                              )),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: RODINACOLOR,
                              )),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}
