
import 'package:flutter/material.dart';
import 'package:sales/styles/colors.dart';

abstract class BaseNavigator {
  void showLoading({String message});
  void showMessage(String message);
  void hideLoading();
}

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
NAV? navigator=null;

}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator{
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }
  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading({String message = "Loading..."}) {
    showDialog(

      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: RODINACOLOR,
          title: Center(child: Container(
            color:  RODINACOLOR,
            child: Row(
              children: [
                Text(message,style:  Theme.of(context).textTheme.headline1,),
                const SizedBox(
                  width: 15,
                ),

                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: RODINACOLOR,
          content: Text(message,style: Theme.of(context).textTheme.headline1,),

        );
      },
    );
  }
}
