import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/base.dart';
import 'package:sales/screens/setting/addUser/addUserScreen/addUser_ViewModel.dart';
import 'package:sales/shared/componant/componants.dart';
import 'package:sales/styles/colors.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  static const String routeName = 'addUser';

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends BaseView<AddUser,AddUser_ViewModel> implements addUser_Navigator{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator=this;
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
                        title: Column(
                          children: [
                            Text(
                              'add user',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.redAccent,
                              onTap: () {},
                              controller: viewModel.emailController,
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
                              controller:viewModel.passwordController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'password',
                                prefixIcon: const Icon(Icons.lock_open),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: RODINACOLOR),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: RODINACOLOR),
                                ),
                              ),
                            ),
                            DefaultElevatedButton(widgets: [
                              Text(
                                'Add',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Icon(Icons.add_task_rounded)
                            ], onPressed: () {
                              viewModel.Login_Account(viewModel.emailController.text, viewModel.passwordController.text);

                            })
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height * .08,
                  child: Card(
                    shadowColor: RODINACOLORPINK,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add User',
                          style: Theme.of(context).textTheme.subtitle1,
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
                  height: MediaQuery.of(context).size.height * .08,
                  child: Card(
                    shadowColor: RODINACOLORPINK,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add User',
                          style: Theme.of(context).textTheme.subtitle1,
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

  @override
  goToBack() {
   Navigator.pop(context);
  }
}

