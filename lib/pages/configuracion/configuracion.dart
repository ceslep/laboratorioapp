// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/configuracion_model.dart';
import 'package:laboratorioapp/widgets/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool cargando = false;
  FToast fToast = FToast();
  late ConfiguracionModel configuracion;
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
        urlFirmaLaboratorioController.text = configuracion.urFirmaLaboratorio!;
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
              onPressed: () {},
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Form(
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'Laboratorio',
                    controller: nombreLaboratorioController,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'Dirección Laboratorio',
                    controller: direccionLaboratorioController,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'Telefonos Laboratorio',
                    controller: telefonosLaboratorioController,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'Correo Electrónico Laboratorio',
                    controller: correoLaboratorioController,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'Sitio Web Laboratorio',
                    controller: webLaboratorioController,
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
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.3 * MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFieldI(
                        labelText: 'Tarjeta Profesional',
                        controller: tarjetaPLaboratorioController,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'URL Firma Bacteriólogo Laboratorio',
                    controller: urlFirmaLaboratorioController,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldI(
                    labelText: 'URL Logo Laboratorio',
                    controller: urlFirmaLaboratorioController,
                  ),
                ),
              ),
            ],
          ),
        ),
        cargando
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox()
      ]),
    );
  }
}
