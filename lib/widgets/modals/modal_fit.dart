import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  final String title;
  const ModalFit({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Row(
        children: [
          SizedBox(
            width: 0.2 * MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage('images/hemat.png'),
              ),
            ),
          ),
          SizedBox(
            width: 0.6 * MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Aceptar',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
