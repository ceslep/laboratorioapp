// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/data-hemat.dart';
import 'package:laboratorioapp/models/hg_rayto.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/form_hemograma.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/form_hemograma_new.dart';
import 'package:laboratorioapp/providers/hrayto_provider.dart';
import 'package:laboratorioapp/providers/url_provider.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          'Registro de Exámenes',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () async {
                DataHemat dataHemat = await getDataHemat(
                    context, widget.paciente.identificacion!, widget.fecha);
                print(dataHemat.toJson());
              },
              icon: const Icon(
                Icons.lan,
                color: Colors.green,
              ),
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
                      guardarHemograma(context, hraytoProvider.hrayto)
                          .then((value) async {
                        setState(() {
                          imprimiendo_ = !imprimiendo_;
                        });
                        printPDFFile(
                          context,
                          "hemogramaRayto",
                          "Hemograma",
                          "hemograma_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                          widget.paciente.identificacion!,
                          widget.fecha,
                          widget.paciente.nombreCompleto,
                          widget.paciente.edad,
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.print,
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
                          color: Colors.lime,
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
                      setState(() => guardando_ = !guardando_);
                      guardarHemograma(context, hraytoProvider.hrayto).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Hemograma almacenado',
                              asset: 'images/hemat.png',
                            ),
                          );
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.green,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/hemat.png'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hemograma',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.paciente.nombreCompleto,
                            style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.fecha,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              FormHemogramaNew(
                hemograma: widget.hemograma,
                identificacion: widget.paciente.identificacion!,
                fecha: widget.fecha,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
