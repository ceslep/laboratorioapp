import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/models/procedimientos_model.dart';

class MostrarSeleccionados extends StatefulWidget {
  final Paciente paciente;
  final String fecha;
  final List<Procedimientos> seleccionados;
  final bool aguardar;
  const MostrarSeleccionados(
      {super.key,
      required this.seleccionados,
      required this.aguardar,
      required this.paciente,
      required this.fecha});

  @override
  State<MostrarSeleccionados> createState() => _MostrarSeleccionadosState();
}

class _MostrarSeleccionadosState extends State<MostrarSeleccionados> {
  late List<Procedimientos> seleccionadoss;

  @override
  void initState() {
    super.initState();
    seleccionadoss = widget.seleccionados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Exámenes Seleccionados'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, seleccionadoss);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.brown,
          ),
        ),
        actions: [
          widget.aguardar
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      guardarExamenes(context, seleccionadoss,
                              widget.paciente.identificacion!, widget.fecha)
                          .then(
                        (value) {},
                      );
                    },
                    icon: const Icon(Icons.save),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: seleccionadoss.isNotEmpty
          ? ListView.builder(
              itemCount: seleccionadoss.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: widget.paciente.genero! == 'Masculino'
                            ? const AssetImage('images/male.png')
                            : const AssetImage('images/female.png'),
                      ),
                      title: Text(
                        widget.paciente.nombreCompleto,
                      ),
                      subtitle: Text(widget.paciente.identificacion!),
                    ),
                  );
                } else {
                  int indexx = index - 1;
                  return index >= 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Text(seleccionadoss[indexx].nombre!),
                              trailing: ElevatedButton(
                                child: const Icon(Icons.delete),
                                onPressed: () {
                                  seleccionadoss.removeAt(indexx);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        )
                      : const SizedBox();
                }
              },
            )
          : const SizedBox(),
    );
  }
}
