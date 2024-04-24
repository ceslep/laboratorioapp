import 'package:flutter/material.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/examen_tipo1_model.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/widgets/modals/floating_modal.dart';
import 'package:laboratorioapp/widgets/modals/modal_fit.dart';
import 'package:laboratorioapp/widgets/text_field.dart';

class ViewExamenTipo1 extends StatefulWidget {
  final ExamenTipo1 examen;
  final Paciente paciente;
  final String fecha;
  const ViewExamenTipo1({
    super.key,
    required this.examen,
    required this.paciente,
    required this.fecha,
  });

  @override
  State<ViewExamenTipo1> createState() => _ViewExamenTipo1State();
}

class _ViewExamenTipo1State extends State<ViewExamenTipo1> {
  bool guardando_ = false;
  ExamenTipo1 examenS = ExamenTipo1();
  late TextEditingController valoracionController;
  @override
  void initState() {
    super.initState();
    valoracionController =
        TextEditingController(text: widget.examen.valoracion!);
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
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo1(context, examenS).then(
                        (value) {
                          if (true) {
                            printPDFFile(
                                context,
                                "examen_tipo_1",
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
                      guardarTipo1(context, examenS).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Parcial de Orina almacenado',
                              asset: 'images/porina.png',
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
            examenS.identificacion = widget.paciente.identificacion;
            examenS.fecha = widget.fecha;
          },
          child: Expanded(
            child: Padding(
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
          )),
    );
  }
}
