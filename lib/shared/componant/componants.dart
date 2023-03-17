import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class TextDialogWidget extends StatefulWidget {
  String value;
  String title;

  TextDialogWidget({required this.value, required this.title});

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
              setState(() {});
            },
            child: Text('Done'))
      ],
    );
  }
}

class DefaultElevatedButton extends StatelessWidget {
  List<Widget> widgets;
Function onPressed;


DefaultElevatedButton({super.key, required this.widgets, required this.onPressed});


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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
     widgets

      ),
    );
  }
}
