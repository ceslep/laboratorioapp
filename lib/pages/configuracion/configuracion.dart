// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/configuracion_model.dart';
import 'package:laboratorioapp/widgets/modals/floating_modal.dart';
import 'package:laboratorioapp/widgets/modals/modal_fit.dart';
import 'package:laboratorioapp/widgets/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool cargando = false;
  bool guardando = false;
  FToast fToast = FToast();
  Color colort = Colors.amber;
  ConfiguracionModel configuracion = ConfiguracionModel();
  late final TextEditingController nitLaboratorioController =
      TextEditingController();
  late final TextEditingController nombreLaboratorioController =
      TextEditingController();
  late final TextEditingController direccionLaboratorioController =
      TextEditingController();
  late final TextEditingController telefonosLaboratorioController =
      TextEditingController();
  late final TextEditingController correoLaboratorioController =
      TextEditingController();
  late final TextEditingController webLaboratorioController =
      TextEditingController();
  late final TextEditingController bacteriologoLaboratorioController =
      TextEditingController();

  late final TextEditingController tarjetaPLaboratorioController =
      TextEditingController();

  late final TextEditingController urlFirmaLaboratorioController =
      TextEditingController();
  late final TextEditingController urlLogoLaboratorioController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    setState(
      () => cargando = !cargando,
    );
    try {
      getConfiguracion(context).then((value) {
        configuracion = value;
        nitLaboratorioController.text = configuracion.nit!;
        nombreLaboratorioController.text = configuracion.nombreLaboratorio!;
        direccionLaboratorioController.text =
            configuracion.direccionLaboratorio!;
        telefonosLaboratorioController.text =
            configuracion.telefonosLaboratorio!;
        correoLaboratorioController.text = configuracion.correoLaboratorio!;
        webLaboratorioController.text = configuracion.webLaboratorio!;
        bacteriologoLaboratorioController.text =
            configuracion.bacteriologoLaboratorio!;
        tarjetaPLaboratorioController.text = configuracion.tarjetaPLaboratorio!;
        urlFirmaLaboratorioController.text = configuracion.urlFirmaLaboratorio!;
        urlLogoLaboratorioController.text = configuracion.urlLogoLaboratorio!;

        setState(
          () => cargando = !cargando,
        );
      });
    } catch (e) {
      showToastB(fToast, 'Error obteniedndo la información de internet',
          bacgroundColor: Colors.red,
          frontColor: Colors.yellow,
          gravity: ToastGravity.BOTTOM_RIGHT,
          icon: Icon(MdiIcons.alert));
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text('Configuración'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  guardando = !guardando;
                });
                guardarConfiguracion(context, configuracion).then(
                  (value) {
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => const ModalFit(
                        title: 'Configuración almacenada',
                        asset: 'images/logo.png',
                      ),
                    );
                    setState(() {
                      guardando = !guardando;
                    });
                  },
                );
              },
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Form(
            onChanged: () {
              if (!cargando) {
                configuracion.nit = nitLaboratorioController.text;
                configuracion.nombreLaboratorio =
                    nombreLaboratorioController.text;
                configuracion.direccionLaboratorio =
                    direccionLaboratorioController.text;
                configuracion.telefonosLaboratorio =
                    telefonosLaboratorioController.text;
                configuracion.correoLaboratorio =
                    correoLaboratorioController.text;
                configuracion.webLaboratorio = webLaboratorioController.text;
                configuracion.bacteriologoLaboratorio =
                    bacteriologoLaboratorioController.text;
                configuracion.tarjetaPLaboratorio =
                    tarjetaPLaboratorioController.text;
                configuracion.urlFirmaLaboratorio =
                    urlFirmaLaboratorioController.text;
                configuracion.urlLogoLaboratorio =
                    urlLogoLaboratorioController.text;
              }
            },
            child: Column(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Nit',
                      controller: nitLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Laboratorio',
                      controller: nombreLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Dirección Laboratorio',
                      controller: direccionLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Telefonos Laboratorio',
                      controller: telefonosLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Correo Electrónico Laboratorio',
                      controller: correoLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Sitio Web Laboratorio',
                      controller: webLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 0.7 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldI(
                          labelText: 'Bacteriólogo',
                          controller: bacteriologoLaboratorioController,
                          colort: colort,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.3 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldI(
                          labelText: 'T.P.',
                          controller: tarjetaPLaboratorioController,
                          colort: colort,
                        ),
                      ),
                    ),
                  ],
                ),
                /* SizedBox(
                  width: 0.95 * MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'URL Firma Bacteriólogo Laboratorio',
                      controller: urlFirmaLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.95 * MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'URL Logo Laboratorio',
                      controller: urlLogoLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ), */
              ],
            ),
          ),
        ),
        cargando
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox()
      ]),
    );
  }
}
