
import 'package:flutter/material.dart';

class TextDialogWidget extends StatefulWidget {

  String value;
  String title;

  TextDialogWidget({required this.value,required this.title});

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=TextEditingController(text: widget.value);
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
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop(controller.text);
          setState(() {
          });
          },
            child: Text('Done'))
      ],
    );
  }
}
