import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/pages/configuracion/configuracion.dart';
import 'package:laboratorioapp/pages/lista_pacientes.dart';
import 'package:laboratorioapp/pages/view_examenes/porfecha/ver_por_fecha.dart';
import 'package:laboratorioapp/widgets/home/home_fl.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Homelaboratorioapp extends StatefulWidget {
  const Homelaboratorioapp({super.key, required this.title});

  final String title;

  @override
  State<Homelaboratorioapp> createState() => _HomelaboratorioappState();
}

class _HomelaboratorioappState extends State<Homelaboratorioapp> {
  bool listando = false;

  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
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
            child: !listando
                ? IconButton(
                    onPressed: () {
                      String fecha =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      setState(() {
                        listando = !listando;
                      });
                      getPacientesFecha(context, fecha).then(
                        (value) {
                          setState(() {
                            listando = !listando;
                          });
                          List<Paciente> pacientes = value;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerPorFecha(
                                pacientes: pacientes,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.purple,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
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
                exit(0);
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
