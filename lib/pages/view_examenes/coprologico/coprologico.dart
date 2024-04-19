import 'dart:io';

import 'package:flutter/material.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/coprologico.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/widgets/modals/floating_modal.dart';
import 'package:laboratorioapp/widgets/modals/modal_fit.dart';

class ViewCoprologico extends StatefulWidget {
  final Coprologico coprologico;
  final Paciente paciente;
  final String fecha;
  const ViewCoprologico(
      {super.key,
      required this.coprologico,
      required this.paciente,
      required this.fecha});

  @override
  State<ViewCoprologico> createState() => _CoprologicoState();
}

class _CoprologicoState extends State<ViewCoprologico> {
  Coprologico coprologicoS = Coprologico();

  late final TextEditingController _consistenciaController;
  late final TextEditingController _colorController;
  late final TextEditingController _sangreController;
  late final TextEditingController _mocoController;
  late final TextEditingController _otrosMacroscopicosController;
  late final TextEditingController _phController;
  late final TextEditingController _endamoebaHistoliticaQuistesController;
  late final TextEditingController _endamoebaColiQuistesController;
  late final TextEditingController _endolimaxQuistesController;
  late final TextEditingController _iodamoebaQuistesController;
  late final TextEditingController _giardaLambliaQuistesController;
  late final TextEditingController _chilomastixMesniliQuistesController;
  late final TextEditingController _trichomonaHominisQuistesController;
  late final TextEditingController _balantidiumColiQuistesController;
  late final TextEditingController _endamoebaHistoliticaTrofozoitosController;
  late final TextEditingController _endamoebaColiTrofozoitosController;
  late final TextEditingController _endolimaxTrofozoitosController;
  late final TextEditingController _iodamoebaTrofozoitosController;
  late final TextEditingController _giardaLambliaTrofozoitosController;
  late final TextEditingController _chilomastixMesniliTrofozoitosController;
  late final TextEditingController _trichomonaHominisTrofozoitosController;
  late final TextEditingController _balantidiumColiTrofozoitosController;
  late final TextEditingController _blastocystisHominisQuistesController;
  late final TextEditingController _blastocystisHominisTrofozoitosController;
  late final TextEditingController _ascarisController;
  late final TextEditingController _tricocefalosController;
  late final TextEditingController _uncinariaController;
  late final TextEditingController _teniaSaginataController;
  late final TextEditingController _teniaSoliumController;
  late final TextEditingController _himenolepsisController;
  late final TextEditingController _strongiloidesLarvaController;
  late final TextEditingController _oxiurosHuevosController;
  late final TextEditingController _sangreOcultaController;
  late final TextEditingController _leucocitosController;

  bool guardando_ = false;

  @override
  void initState() {
    super.initState();

    _consistenciaController =
        TextEditingController(text: widget.coprologico.consistencia);

    _colorController = TextEditingController(text: widget.coprologico.color);
    _sangreController = TextEditingController(text: widget.coprologico.sangre);
    _mocoController = TextEditingController(text: widget.coprologico.moco);
    _otrosMacroscopicosController =
        TextEditingController(text: widget.coprologico.otrosMacroscopicos);

    _phController = TextEditingController(text: widget.coprologico.ph);
    _endamoebaHistoliticaQuistesController = TextEditingController(
        text: widget.coprologico.endamoebaHistoliticaQuistes);

    _endamoebaColiQuistesController =
        TextEditingController(text: widget.coprologico.endamoebaColiQuistes);

    _endolimaxQuistesController =
        TextEditingController(text: widget.coprologico.endolimaxQuistes);

    _iodamoebaQuistesController =
        TextEditingController(text: widget.coprologico.iodamoebaQuistes);

    _giardaLambliaQuistesController =
        TextEditingController(text: widget.coprologico.giardaLambliaQuistes);

    _chilomastixMesniliQuistesController = TextEditingController(
        text: widget.coprologico.chilomastixMesniliQuistes);

    _trichomonaHominisQuistesController = TextEditingController(
        text: widget.coprologico.trichomonaHominisQuistes);

    _balantidiumColiQuistesController = TextEditingController(
        text: widget.coprologico.balantidiumColiTrofozoitos);

    _endamoebaHistoliticaTrofozoitosController = TextEditingController(
        text: widget.coprologico.endamoebaHistoliticaTrofozoitos);

    _endamoebaColiTrofozoitosController = TextEditingController(
        text: widget.coprologico.endamoebaColiTrofozoitos);

    _endolimaxTrofozoitosController =
        TextEditingController(text: widget.coprologico.endolimaxTrofozoitos);

    _iodamoebaTrofozoitosController =
        TextEditingController(text: widget.coprologico.iodamoebaQuistes);

    _giardaLambliaTrofozoitosController =
        TextEditingController(text: widget.coprologico.giardaLambliaQuistes);

    _chilomastixMesniliTrofozoitosController = TextEditingController(
        text: widget.coprologico.chilomastixMesniliTrofozoitos);

    _trichomonaHominisTrofozoitosController = TextEditingController(
        text: widget.coprologico.trichomonaHominisTrofozoitos);

    _balantidiumColiTrofozoitosController = TextEditingController(
        text: widget.coprologico.balantidiumColiTrofozoitos);

    _blastocystisHominisQuistesController = TextEditingController(
        text: widget.coprologico.blastocystisHominisQuistes);

    _blastocystisHominisTrofozoitosController = TextEditingController(
        text: widget.coprologico.blastocystisHominisTrofozoitos);

    _ascarisController =
        TextEditingController(text: widget.coprologico.ascaris);
    _tricocefalosController =
        TextEditingController(text: widget.coprologico.tricocefalos);

    _uncinariaController =
        TextEditingController(text: widget.coprologico.uncinaria);

    _teniaSaginataController =
        TextEditingController(text: widget.coprologico.teniaSaginata);

    _teniaSoliumController =
        TextEditingController(text: widget.coprologico.teniaSolium);

    _himenolepsisController =
        TextEditingController(text: widget.coprologico.himenolepsis);

    _strongiloidesLarvaController =
        TextEditingController(text: widget.coprologico.strongiloidesLarva);

    _oxiurosHuevosController =
        TextEditingController(text: widget.coprologico.oxiurosHuevos);

    _sangreOcultaController =
        TextEditingController(text: widget.coprologico.sangreOculta);

    _leucocitosController =
        TextEditingController(text: widget.coprologico.lecucocitos);
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    String value = controller.text;
    value = value != 'null' ? value : '';
    controller.text = value;
    return TextFormField(
      validator: (value) {
        if (value == '') return 'Falta el valor de este campo';
        return null;
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.blueGrey,
        ),
      ),
      style: const TextStyle(color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Coprológico'),
            Row(
              children: [
                Text(
                  widget.paciente.nombreCompleto,
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(width: 5),
                Text(
                  widget.fecha,
                  style: const TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarCoprologico(context, coprologicoS).then(
                        (value) {
                          if (Platform.isWindows) {
                            downloadPDFFile(
                                context,
                                "parcialOrina",
                                "Parcial de Orina",
                                "parcialOrina_${widget.paciente.identificacion}_${widget.fecha}.pdf",
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
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarCoprologico(context, coprologicoS).then(
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
        ],
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {},
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTextField('Consistencia', _consistenciaController),
              _buildTextField('Color', _colorController),
              _buildTextField('Sangre', _sangreController),
              _buildTextField('Moco', _mocoController),
              _buildTextField(
                  'Otros Macroscopicos', _otrosMacroscopicosController),
              _buildTextField('Ph', _phController),
              _buildTextField('Endamoeba Histolitica Quistes',
                  _endamoebaHistoliticaQuistesController),
              _buildTextField(
                  'Endamoeba Coli Quistes', _endamoebaColiQuistesController),
              _buildTextField('Endolimax Quistes', _endolimaxQuistesController),
              _buildTextField('Iodamoeba Quistes', _iodamoebaQuistesController),
              _buildTextField(
                  'Giarda Lamblia Quistes', _giardaLambliaQuistesController),
              _buildTextField('Chilomastix Mesnili Quistes',
                  _chilomastixMesniliQuistesController),
              _buildTextField('Trichomona Hominis Quistes',
                  _trichomonaHominisQuistesController),
              _buildTextField('Balantidium Coli Quistes ',
                  _balantidiumColiQuistesController),
              _buildTextField('Endamoeba Histolitica Trofozoitos',
                  _endamoebaHistoliticaTrofozoitosController),
              _buildTextField('Endamoeba Coli Trofozoitos',
                  _endamoebaColiTrofozoitosController),
              _buildTextField(
                  'Endolimax Trofozoitos', _endolimaxTrofozoitosController),
              _buildTextField(
                  'Iodamoeba Trofozoitos', _iodamoebaTrofozoitosController),
              _buildTextField('Giarda Lamblia Trofozoitos',
                  _giardaLambliaTrofozoitosController),
              _buildTextField('Chilomastix Mesnili Trofozoitos',
                  _chilomastixMesniliTrofozoitosController),
              _buildTextField('Trichomona Hominis Trofozoitos',
                  _trichomonaHominisTrofozoitosController),
              _buildTextField('Balantidium Coli Trofozoitos',
                  _balantidiumColiTrofozoitosController),
              _buildTextField('Blastocystis Hominis Quistes',
                  _blastocystisHominisQuistesController),
              _buildTextField('Blastocystis Hominis Trofozoitos',
                  _blastocystisHominisTrofozoitosController),
              _buildTextField('Ascaris Controller', _ascarisController),
              _buildTextField('Tricocefalos', _tricocefalosController),
              _buildTextField('Uncinaria', _uncinariaController),
              _buildTextField('Tenia Saginata', _teniaSaginataController),
              _buildTextField('Tenia Solium', _teniaSoliumController),
              _buildTextField('Himenolepsis', _himenolepsisController),
              _buildTextField(
                  'Strongiloides Larva', _strongiloidesLarvaController),
              _buildTextField('Oxiuros Huevos', _oxiurosHuevosController),
              _buildTextField('sangre Oculta', _sangreOcultaController),
              _buildTextField('leucocitos', _leucocitosController),
            ],
          ),
        ),
      ),
    );
  }
}
