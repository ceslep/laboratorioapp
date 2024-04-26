import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laboratorioapp/pages/configuracion/configuracion.dart';
import 'package:laboratorioapp/pages/lista_pacientes.dart';
import 'package:laboratorioapp/widgets/home/home_fl.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Homelaboratorioapp extends StatelessWidget {
  Homelaboratorioapp({super.key, required this.title});

  final String title;

  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Configuracion()),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListaPacientes(),
                    ));
              },
              icon: Icon(
                MdiIcons.listBox,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                //     exit(0);
              },
              icon: Icon(
                MdiIcons.exitToApp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BodyHome(fechaController: _fechaController),
      floatingActionButton: FloatingActionButtonHome(
        fecha: _fechaController.text,
      ),
    );
  }
}
