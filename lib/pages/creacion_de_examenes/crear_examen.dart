// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/models/procedimientos_model.dart';
import 'package:laboratorioapp/pages/creacion_de_examenes/asignar_examenes.dart';
import 'package:laboratorioapp/widgets/date_picker.dart';

class CrearExamen extends StatefulWidget {
  const CrearExamen({
    super.key,
  });

  @override
  State<CrearExamen> createState() => _CrearExamenState();
}

class _CrearExamenState extends State<CrearExamen> {
  bool cargandoProcedimientos = false;
  Paciente paciente = Paciente();
  Uri url = Uri();
  final TextEditingController _fechaController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final TextEditingController _identificacionController =
      TextEditingController();
  bool buscando = false;

  @override
  void initState() {
    super.initState();
    _identificacionController.addListener(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Crear Exámenes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildDatePicker(
                context,
                _fechaController,
                'Fecha de Exámenes',
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 0.8 * MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length < 3) {
                            setState(() => paciente = Paciente());
                          }
                        },
                        autofocus: true,
                        controller: _identificacionController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Paciente',
                          hintText: 'Identificación del paciente',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _identificacionController.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.2 * MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() => buscando = !buscando);
                          paciente = await getInfoPaciente(context,
                              identificacion: _identificacionController.text);
                          setState(() => buscando = !buscando);
                        },
                        child: !buscando
                            ? const Icon(Icons.search)
                            : const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: paciente.nombres != null
                    ? ListTile(
                        title: Text(
                          '${paciente.nombres} ${paciente.apellidos}',
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(paciente.edad),
                            Text(paciente.genero!),
                            Text('Fecha:${_fechaController.text}'),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => const Color.fromARGB(
                                              255, 255, 255, 255)),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => const Color.fromARGB(
                                              255, 78, 39, 78)),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    cargandoProcedimientos =
                                        !cargandoProcedimientos;
                                  });
                                  getProcedimientos(context).then(
                                    (value) async {
                                      setState(() {
                                        cargandoProcedimientos =
                                            !cargandoProcedimientos;
                                      });
                                      List<Procedimientos> procedimientos =
                                          value;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AsignarExamenes(
                                                    paciente: paciente,
                                                    fecha:
                                                        _fechaController.text,
                                                    procedimientos:
                                                        procedimientos)),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Asignar Exámenes",
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: cargandoProcedimientos
                                          ? const CircularProgressIndicator(
                                              strokeWidth: 2,
                                            )
                                          : const SizedBox(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
