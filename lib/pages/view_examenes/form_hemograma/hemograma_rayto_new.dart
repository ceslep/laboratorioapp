// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/hg_rayto.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/pages/printpdf/print_pdf.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/form_hemograma.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/form_hemograma_new.dart';
import 'package:laboratorioapp/providers/hrayto_provider.dart';
import 'package:laboratorioapp/providers/url_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:open_share_plus/open.dart';

import '../../../widgets/modals/floating_modal.dart';
import '../../../widgets/modals/modal_fit.dart';

class ViewHemogramaRaytoNew extends StatefulWidget {
  final HRayto hemograma;
  final Paciente paciente;
  final String fecha;

  const ViewHemogramaRaytoNew({
    super.key,
    required this.hemograma,
    required this.fecha,
    required this.paciente,
  });

  @override
  State<ViewHemogramaRaytoNew> createState() => _ViewHemogramaRaytoNewState();
}

class _ViewHemogramaRaytoNewState extends State<ViewHemogramaRaytoNew> {
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
              String url =
                  '${urlProvider.url}printphp/print_hemograma.php?identificacion=${widget.paciente.identificacion}&fecha=${widget.fecha}&nombres=${widget.paciente.nombreCompleto}';
              Open.whatsApp(
                  whatsAppNumber: widget.paciente.telefono, text: url);
            },
            icon: Icon(
              MdiIcons.whatsapp,
              color: Colors.lightGreenAccent,
            ),
          ),
          IconButton(
            tooltip: 'Enviar por correo',
            onPressed: () async {
              String url =
                  '${urlProvider.url}printphp/print_hemograma.php?identificacion=${widget.paciente.identificacion}&fecha=${widget.fecha}&nombres=${widget.paciente.nombreCompleto}';
              Open.mail(
                  toAddress: widget.paciente.correo!,
                  subject: "hemograma",
                  body: url);
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
                                    nombres: widget.paciente.nombreCompleto),
                              ),
                            );
                          } else if (Platform.isWindows) {
                            downloadPDFFile(
                                context,
                                'print_hemograma',
                                "hemograma_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                                widget.paciente.identificacion!,
                                widget.fecha,
                                widget.paciente.nombres!);
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
      body: FormHemogramaNew(
        hemograma: widget.hemograma,
        identificacion: widget.paciente.identificacion!,
        fecha: widget.hemograma.fecha ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );
  }
}
