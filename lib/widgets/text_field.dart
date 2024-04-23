import 'package:flutter/material.dart';

class TextFieldI extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Color? colort;
  const TextFieldI(
      {super.key,
      required this.labelText,
      required this.controller,
      this.colort = Colors.blue});

  Widget _buildTextFieldI(
      String labelText, TextEditingController controller, Color color) {
    String value = controller.text;
    value = value != 'null' ? value : '';
    controller.text = value;
    return TextFormField(
      validator: (value) {
        if (value == '') return 'Falta el valor de este campo';
        return null;
      },
      onChanged: (value) {},
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
      ),
      style: TextStyle(color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextFieldI(labelText, controller, colort!);
  }
}
