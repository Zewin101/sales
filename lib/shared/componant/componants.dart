import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class TextDialogWidget extends StatefulWidget {
  String value;
  String title;
  Function? dialogFunction;
  TextEditingController? dialogController=TextEditingController();

  TextDialogWidget({required this.value, required this.title,this.dialogController,this.dialogFunction});

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController dialogController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dialogController = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title,
      style: Theme.of(context).textTheme.subtitle1,
      ),
      content: TextField(
        keyboardType: TextInputType.text,
        controller: dialogController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DefaultElevatedButton(
                  widgets: [
                    Text(
                      textAlign: TextAlign.center,
                      "save ",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                  onPressed: (){
                    widget.dialogFunction!();
                    Navigator.pop(context);
                    setState(() {

                    });

                  }),
            ),
          ],
        )
      ],
    );
  }
}

class DefaultElevatedButton extends StatelessWidget {
  List<Widget> widgets;
  Function onPressed;
  Color? color;

  DefaultElevatedButton(
      {this.color, required this.widgets, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(RODINACOLOR),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: widgets),
    );
  }
}
