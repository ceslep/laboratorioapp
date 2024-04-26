import 'package:flutter/material.dart';
import 'package:laboratorioapp/models/procedimientos_model.dart';

class MostrarSeleccionados extends StatefulWidget {
  final List<Procedimientos> seleccionados;
  const MostrarSeleccionados({super.key, required this.seleccionados});

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
        ),
        body: ListView.builder(
          itemCount: seleccionadoss.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(seleccionadoss[index].nombre!),
              trailing: ElevatedButton(
                child: const Icon(Icons.delete),
                onPressed: () {
                  seleccionadoss.removeAt(index);
                  setState(() {});
                },
              ),
            ),
          ),
        ));
  }
}
