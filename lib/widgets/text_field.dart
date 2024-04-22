import 'package:flutter/material.dart';

class TextFieldI extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  const TextFieldI(
      {super.key, required this.labelText, required this.controller});

  @override
  State<TextFieldI> createState() => _TextFieldIState();
}

class _TextFieldIState extends State<TextFieldI> {
  Widget _buildTextFieldI(String labelText, TextEditingController controller) {
    String value = controller.text;
    value = value != 'null' ? value : '';
    controller.text = value;
    return TextFormField(
      validator: (value) {
        if (value == '') return 'Falta el valor de este campo';
        return null;
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
      ),
      style: const TextStyle(color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextFieldI(widget.labelText, widget.controller);
  }
}
