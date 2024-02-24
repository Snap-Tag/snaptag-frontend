import 'package:flutter/material.dart';

TextEditingController _textFieldController = TextEditingController();

Future<void> _displayTextInputDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('TextField in Dialog'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: "Text Field in Dialog"),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              print(_textFieldController.text);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
