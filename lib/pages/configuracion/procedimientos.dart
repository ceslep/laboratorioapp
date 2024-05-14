import 'package:flutter/material.dart';
import 'package:laboratorioapp/models/procedimientos_model.dart';

class ProcedimientosPage extends StatefulWidget {
  final Procedimientos procedimiento;
  const ProcedimientosPage({super.key, required this.procedimiento});

  @override
  State<ProcedimientosPage> createState() => _ProcedimientosPageState();
}

class _ProcedimientosPageState extends State<ProcedimientosPage> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController tablaController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController constanteController = TextEditingController();
  final TextEditingController unidadesController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController tipoProcedimientoController =
      TextEditingController();
  final TextEditingController abreviaturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.procedimiento.nombre!;
    tablaController.text = widget.procedimiento.tabla!;
    infoController.text = widget.procedimiento.info!;
    colorController.text = widget.procedimiento.color!;
    constanteController.text = widget.procedimiento.constante!;
    unidadesController.text = widget.procedimiento.unidades!;
    tipoController.text = widget.procedimiento.tipo!;
    tipoProcedimientoController.text = widget.procedimiento.tipoprocedimiento!;
    abreviaturaController.text = widget.procedimiento.abreviatura!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.lightGreenAccent,
        title: Text('Editar Exámen ${widget.procedimiento.codigo}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre Exámen',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: tablaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tabla',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: infoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Info',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: colorController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Color',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: constanteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Constante',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: unidadesController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Unidades',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: tipoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tipo',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: tipoProcedimientoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tipo de Procedimiento',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: abreviaturaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Abreviatura',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
