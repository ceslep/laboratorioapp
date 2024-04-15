// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/hemograma_rayto.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/form_hemograma.dart';
import 'package:laboratorioapp/providers/hrayto_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/modals/floating_modal.dart';
import '../../../widgets/modals/modal_fit.dart';

class ViewHemogramaRayto extends StatefulWidget {
  final HemogramaRayto hemograma;
  final String identificacion;
  final String fecha;
  final String nombres;
  const ViewHemogramaRayto({
    super.key,
    required this.hemograma,
    required this.identificacion,
    required this.fecha,
    required this.nombres,
  });

  @override
  State<ViewHemogramaRayto> createState() => _ViewHemogramaRaytoState();
}

List<Map<String, dynamic>> parseText(String text) {
  final lines = text.split('\n');
  final List<Map<String, dynamic>> results = [];

  for (final line in lines) {
    if (line == '') continue;
    final parts = line.split(':');
    final key = parts[0].trim();
    final value = parts[1].trim();

    // Convertir a tipos de datos específicos

    results.add({
      key: value,
    });
  }

  return results;
}

class _ViewHemogramaRaytoState extends State<ViewHemogramaRayto> {
  void onFormHemogramaChange(FormHemograma formState) {}

  FToast fToast = FToast();
  List<Map<String, dynamic>> dataHemograma = List.empty();
  String sistematizado = '';
  late HRaytoProvider hraytoProvider;
  @override
  void initState() {
    super.initState();
    hraytoProvider = Provider.of<HRaytoProvider>(context, listen: false);
    fToast.init(context);
    try {
      String resultadoExamen = widget.hemograma.sistematizado!;
      print(resultadoExamen);
      dataHemograma = parseText(resultadoExamen);
      print(dataHemograma);
    } catch (_) {
      showToastB(
        fToast,
        "Error al cargar los campos del hemograma o no existe.",
        bacgroundColor: Colors.red,
        frontColor: Colors.yellow,
        icon: const Icon(
          Icons.dangerous_outlined,
          color: Colors.lightGreenAccent,
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        title: const Text(
          'Hemograma Rayto 7600',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () async {
                guardarHemograma(context, hraytoProvider.hrayto).then(
                  (value) {
                    downloadPDFFile(
                        context,
                        'print_hemograma',
                        "hemograma_${widget.identificacion}_${widget.fecha}.pdf",
                        widget.identificacion,
                        widget.fecha,
                        widget.nombres);
                  },
                );
              },
              icon: const Icon(
                Icons.print,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () async {
                guardarHemograma(context, hraytoProvider.hrayto).then(
                  (value) {
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => const ModalFit(
                        title: 'Hemograma almacenado',
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.save,
                color: Colors.lightGreenAccent,
              ),
            ),
          ),
        ],
      ),
      body: FormHemograma(
        hemograma: dataHemograma,
        identificacion: widget.identificacion,
        fecha: widget.hemograma.fecha ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );
  }
}
