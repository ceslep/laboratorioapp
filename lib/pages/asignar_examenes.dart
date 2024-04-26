// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:laboratorioapp/models/procedimientos_model.dart';
import 'package:laboratorioapp/pages/creacion_de_examenes/mostrar_seleccionados.dart';
import 'package:laboratorioapp/widgets/mostrar_seleccionados.dart';

class AsignarExamenes extends StatefulWidget {
  final List<Procedimientos> procedimientos;
  final List<bool>? checkeds;
  const AsignarExamenes(
      {super.key, required this.procedimientos, this.checkeds});

  @override
  State<AsignarExamenes> createState() => _AsignarExamenesState();
}

class _AsignarExamenesState extends State<AsignarExamenes> {
  List<bool> _isCheckedList = [];
  late List<Procedimientos> procedimientoss;
  final TextEditingController busquedaController = TextEditingController();
  List<Procedimientos> seleccionados = [];
  @override
  void initState() {
    super.initState();
    print({widget.checkeds});
    if ((widget.checkeds == null)) {
      _isCheckedList = List<bool>.filled(widget.procedimientos.length, false);
    } else {
      if (widget.checkeds!.isNotEmpty) {
        _isCheckedList = widget.checkeds!;
      }
    }
    procedimientoss = widget.procedimientos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleccione los Exámenes',
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.red.shade100,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _isCheckedList),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye),
              onPressed: () async {
                List<Procedimientos> result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MostrarSeleccionados(seleccionados: seleccionados),
                  ),
                );
                seleccionados = result;
                setState(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.done),
              onPressed: () => Navigator.pop(context, _isCheckedList),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: procedimientoss.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    if (value.length > 3) {
                      procedimientoss = widget.procedimientos
                          .where((Procedimientos procedimiento) => procedimiento
                              .nombre!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    } else {
                      procedimientoss = widget.procedimientos;
                    }
                    setState(() {});
                  },
                  controller: busquedaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Busqueda de Examenes',
                  ),
                ),
              );
            } else if (index == 1) {
              return const SizedBox();
            } else {
              int indexx = index - 2;
              return Card(
                color: _isCheckedList[indexx]
                    ? Colors.amber.shade50
                    : Colors.white,
                child: ListTile(
                  title: Text(
                    procedimientoss[indexx].nombre!,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromARGB(255, 229, 255, 136)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromARGB(255, 78, 39, 78)),
                    ),
                    onPressed: () {
                      setState(() {
                        seleccionados.add(procedimientoss[indexx]);
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              );
            }
          }),
    );
  }
}
