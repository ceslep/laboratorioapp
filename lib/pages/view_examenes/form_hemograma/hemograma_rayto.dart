// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/hemograma_rayto.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/pages/printpdf/print_pdf.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/form_hemograma.dart';
import 'package:laboratorioapp/providers/hrayto_provider.dart';
import 'package:laboratorioapp/providers/url_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:open_share_plus/open.dart';

import '../../../widgets/modals/floating_modal.dart';
import '../../../widgets/modals/modal_fit.dart';

class ViewHemogramaRayto extends StatefulWidget {
  final HemogramaRayto hemograma;
  final Paciente paciente;
  final String fecha;

  const ViewHemogramaRayto({
    super.key,
    required this.hemograma,
    required this.fecha,
    required this.paciente,
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

  bool imprimiendo_ = false;
  bool guardando_ = false;
  FToast fToast = FToast();
  List<Map<String, dynamic>> dataHemograma = List.empty();
  String sistematizado = '';
  late HRaytoProvider hraytoProvider;
  late UrlProvider urlProvider;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    hraytoProvider = Provider.of<HRaytoProvider>(context, listen: false);
    urlProvider = Provider.of<UrlProvider>(context, listen: false);
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
            fontSize: 12,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Compartir via whatsapp',
            onPressed: () async {
              Open.whatsApp(
                  whatsAppNumber: widget.paciente.telefono,
                  text:
                      '${urlProvider.url}printphp/print_hemograma.php?identificacion=${widget.paciente.identificacion}&fecha=${widget.fecha}&nombres=${widget.paciente.nombres}');

              /* final file =
                  await FilePicker.platform.pickFiles(type: FileType.any);
              if (file != null) {
                final path = file.files.single.path;
                await _shareFile(path!);
              } */
            },
            icon: Icon(
              MdiIcons.whatsapp,
              color: Colors.lightGreenAccent,
            ),
          ),
          IconButton(
            tooltip: 'Enviar por correo',
            onPressed: () async {
              Open.mail(
                  toAddress: widget.paciente.correo!,
                  subject: "hemograma",
                  body:
                      '${urlProvider.url}printphp/print_examen.php?identificacion=${widget.paciente.identificacion}&fecha=${widget.fecha}&nombres=${widget.paciente.nombreCompleto}&info=${'Hemograma sistematizado'}&tabla=${'hemogramaRayto'}');
            },
            icon: const Icon(
              Icons.email,
              color: Colors.lightBlueAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: !imprimiendo_
                ? IconButton(
                    tooltip: 'Imprimir pdf',
                    onPressed: () async {
                      setState(() {
                        imprimiendo_ = !imprimiendo_;
                      });
                      guardarHemograma(context, hraytoProvider.hrayto).then(
                        (value) async {
                          setState(() {
                            imprimiendo_ = !imprimiendo_;
                          });
                          if (Platform.isAndroid) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFRemoteViewer(
                                    urlpdf:
                                        "${urlProvider.url}print_hemograma.php",
                                    identificacion:
                                        widget.paciente.identificacion!,
                                    fecha: widget.fecha,
                                    nombres: widget.paciente.nombres!),
                              ),
                            );
                          } else if (Platform.isWindows) {
                            downloadPDFFile(
                                context,
                                "hemogramaRayto",
                                "Hemograma Sistematizado",
                                "hemograma_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                                widget.paciente.identificacion!,
                                widget.fecha,
                                widget.paciente.nombreCompleto);
                          }
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.print,
                      color: Colors.white,
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
            padding: const EdgeInsets.all(8),
            child: !guardando_
                ? IconButton(
                    tooltip: 'Guardar',
                    onPressed: () async {
                      setState(() {
                        guardando_ = !guardando_;
                      });
                      guardarHemograma(context, hraytoProvider.hrayto).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Hemograma almacenado',
                              asset: 'images/hemat.png',
                            ),
                          );
                          setState(() {
                            guardando_ = !guardando_;
                          });
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.lightGreenAccent,
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
      body: FormHemograma(
        hemograma: dataHemograma,
        identificacion: widget.paciente.identificacion!,
        fecha: widget.hemograma.fecha ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );
  }
}
