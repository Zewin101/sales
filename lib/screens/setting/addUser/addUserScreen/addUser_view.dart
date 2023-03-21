import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/models/myUser.dart';
import 'package:sales/screens/setting/addUser/addUserScreen/addUser_ViewModel.dart';
import 'package:sales/shared/componant/componants.dart';
import 'package:sales/styles/colors.dart';

import '../../../../provider/my_provider.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  static const String routeName = 'addUser';

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends BaseView<AddUser, AddUser_ViewModel>
    implements addUser_Navigator {
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: RODINACOLOR,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          'add user',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                        const Icon(
                                          Icons.people_outline_sharp,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return 'name';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  cursorColor: Colors.redAccent,
                                  onTap: () {},
                                  controller: viewModel.nameController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'User Name',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RODINACOLOR,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RODINACOLOR,
                                        )),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return 'Enter email';
                                    }

                                    final bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value);
                                    if (!emailValid)
                                      return 'Type the email correctly';
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.redAccent,
                                  onTap: () {},
                                  controller: viewModel.emailController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    labelText: 'email',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RODINACOLOR,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RODINACOLOR,
                                        )),
                                  ),
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.redAccent,
                                  validator: (value) {
                                    if (value!.isEmpty || value.trim() == '') {
                                      return 'Enter username';
                                    }

                                    return null;
                                  },
                                  onTap: () {},
                                  controller: viewModel.phoneController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    labelText: 'phone',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RODINACOLOR,
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: RODINACOLOR,
                                        )),
                                  ),
                                  textInputAction: TextInputAction.next,
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
                                  decoration: InputDecoration(
                                    labelText: 'password',
                                    prefixIcon: const Icon(Icons.lock_open),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: RODINACOLOR),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: RODINACOLOR),
                                    ),
                                  ),
                                ),
                                DefaultElevatedButton(
                                    widgets: [
                                      Text(
                                        'Add',
                                        style:
                                        Theme
                                            .of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      Icon(Icons.add_task_rounded)
                                    ],
                                    onPressed: () {
                                      addNewUser();
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .08,
                  child: Card(
                    shadowColor: RODINACOLORPINK,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add User',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Icon(Icons.ac_unit),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .08,
                  child: Card(
                    shadowColor: RODINACOLORPINK,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add User',
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1,
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AddUser_ViewModel initViewModel() {
    return AddUser_ViewModel();
  }




  void addNewUser() {
    if (formKey.currentState!.validate()) {
      viewModel.createNewUser(email: viewModel.emailController.text,
          password: viewModel.passwordController.text,
          name: viewModel.nameController.text,
          phone: viewModel.phoneController.text);
    }
  }

  @override
  void goToBack(rodinaKidsUser) {
    Navigator.pop(context);  }
}
