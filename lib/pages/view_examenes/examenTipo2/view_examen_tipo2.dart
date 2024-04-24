import 'package:flutter/material.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/examen_tipo2_model.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/widgets/modals/floating_modal.dart';
import 'package:laboratorioapp/widgets/modals/modal_fit.dart';
import 'package:laboratorioapp/widgets/text_field.dart';

class ViewExamenTipo2 extends StatefulWidget {
  final ExamenTipo2 examen;
  final Paciente paciente;
  final String fecha;
  const ViewExamenTipo2({
    super.key,
    required this.examen,
    required this.paciente,
    required this.fecha,
  });

  @override
  State<ViewExamenTipo2> createState() => _ViewExamenTipo2State();
}

class _ViewExamenTipo2State extends State<ViewExamenTipo2> {
  bool guardando_ = false;
  ExamenTipo2 examenS = ExamenTipo2();
  late TextEditingController valoracionController;
  late TextEditingController observacionesController;
  @override
  void initState() {
    super.initState();
    if (widget.examen.valoracion != null) {
      valoracionController =
          TextEditingController(text: widget.examen.valoracion!);
    }
    if (widget.examen.observaciones != null) {
      observacionesController =
          TextEditingController(text: widget.examen.observaciones!);
    }
    examenS = widget.examen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/lab.png'),
            ),
            const SizedBox(width: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.examen.nombreExamen!,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.paciente.nombreCompleto,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.fecha,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        actions: [
          /*  IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WebViewLab()),
              );
            },
            icon: const Icon(Icons.web),
          ), */
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo2(context, examenS).then(
                        (value) {
                          if (true) {
                            printPDFFile(
                                context,
                                "examen_tipo_2",
                                widget.examen.nombreExamen!,
                                "${widget.examen.nombreExamen!}_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                                widget.paciente.identificacion!,
                                widget.fecha,
                                widget.paciente.nombreCompleto);
                          }
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.print,
                      color: Colors.brown,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo2(context, examenS).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => ModalFit(
                              title:
                                  '${examenS.nombreExamen!} almacenada con éxito',
                              asset: 'images/lab.png',
                            ),
                          );
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.blueGrey,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: Form(
          onChanged: () {
            examenS.valoracion = valoracionController.text;
            examenS.observaciones = observacionesController.text;
            examenS.identificacion = widget.paciente.identificacion;
            examenS.fecha = widget.fecha;
          },
          child: Expanded(
            flex: 3,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 0.2 * MediaQuery.of(context).size.width,
                        child: TextFieldI(
                            labelText: 'Valoración',
                            controller: valoracionController),
                      ),
                      SizedBox(
                        width: 0.2 * MediaQuery.of(context).size.width,
                        child: Text(widget.examen.unidades!),
                      ),
                      SizedBox(
                        width: 0.4 * MediaQuery.of(context).size.width,
                        child: Text('Normal: ${widget.examen.constant!}'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.95 * MediaQuery.of(context).size.width,
                  child: TextFieldI(
                      labelText: 'Observaciones',
                      controller: observacionesController),
                ),
              ],
            ),
          )),
    );
  }
}
