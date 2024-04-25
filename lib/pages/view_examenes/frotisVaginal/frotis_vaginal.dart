import 'package:flutter/material.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/models/frotis_vaginal_model.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/widgets/modals/floating_modal.dart';
import 'package:laboratorioapp/widgets/modals/modal_fit.dart';

class ViewFrotisVaginal extends StatefulWidget {
  final FrotisVaginal frotisVaginal;
  final Paciente paciente;
  final String fecha;

  const ViewFrotisVaginal(
      {super.key,
      required this.paciente,
      required this.frotisVaginal,
      required this.fecha});

  @override
  State<ViewFrotisVaginal> createState() => _ViewFrotisVaginalState();
}

class _ViewFrotisVaginalState extends State<ViewFrotisVaginal> {
  FrotisVaginal frotisVaginalS = FrotisVaginal();
  bool guardando_ = false;
  late final TextEditingController _otrosFrescoController;
  late final TextEditingController _pruebaDeAminasController;
  late final TextEditingController _celulasGuia1Controller;
  late final TextEditingController _phController;
  late final TextEditingController _trichonomasVaginalesController;
  late final TextEditingController _pmnController;
  late final TextEditingController _celulasGuia2Controller;
  late final TextEditingController _blastoconidiasController;
  late final TextEditingController _seudomiceliosController;
  late final TextEditingController _lactobacillusController;
  late final TextEditingController _gardnerellaSpController;
  late final TextEditingController _bacteroidesSpController;
  late final TextEditingController _mobilluncusSpController;
  late final TextEditingController _pmnxController;
  late final TextEditingController _intracelularesController;
  late final TextEditingController _extracelularesController;
  late final TextEditingController _observacionesController;

  @override
  void initState() {
    super.initState();

    _otrosFrescoController =
        TextEditingController(text: widget.frotisVaginal.otrosFresco);
    _pruebaDeAminasController =
        TextEditingController(text: widget.frotisVaginal.pruebaDeAminas);
    _celulasGuia1Controller =
        TextEditingController(text: widget.frotisVaginal.celulasGuia1);
    _phController = TextEditingController(text: widget.frotisVaginal.ph);
    _trichonomasVaginalesController =
        TextEditingController(text: widget.frotisVaginal.trichonomasVaginales);
    _pmnController = TextEditingController(text: widget.frotisVaginal.pmn);
    _celulasGuia2Controller =
        TextEditingController(text: widget.frotisVaginal.celulasGuia2);
    _blastoconidiasController =
        TextEditingController(text: widget.frotisVaginal.blastoconidias);
    _seudomiceliosController =
        TextEditingController(text: widget.frotisVaginal.seudomicelios);
    _lactobacillusController =
        TextEditingController(text: widget.frotisVaginal.lactobacillus);
    _gardnerellaSpController =
        TextEditingController(text: widget.frotisVaginal.gardnerellaSp);
    _bacteroidesSpController =
        TextEditingController(text: widget.frotisVaginal.bacteroidesSp);
    _mobilluncusSpController =
        TextEditingController(text: widget.frotisVaginal.mobilluncusSp);
    _pmnxController = TextEditingController(text: widget.frotisVaginal.pmnx);
    _intracelularesController =
        TextEditingController(text: widget.frotisVaginal.intracelulares);
    _extracelularesController =
        TextEditingController(text: widget.frotisVaginal.extracelulares);
    _observacionesController =
        TextEditingController(text: widget.frotisVaginal.observaciones);
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                const Text(
                  'Frotis Vaginal',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.paciente.nombreCompleto,
                          style: const TextStyle(
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          widget.fecha,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.brown,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarFrotisVaginal(context, frotisVaginalS).then(
                        (value) {
                          if (true) {
                            printPDFFile(
                                context,
                                "coprologico",
                                "Exámen Coprológico",
                                "coprologico_${widget.paciente.identificacion}_${widget.fecha}.pdf",
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
                      guardarFrotisVaginal(context, frotisVaginalS).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => const ModalFit(
                              title: 'Exámen Frotis Vaginal almacenado',
                              asset: 'images/lab.png',
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
      body: SingleChildScrollView(
        child: Form(
          onChanged: () {
            frotisVaginalS.identificacion = widget.paciente.identificacion;
            frotisVaginalS.fecha = widget.fecha;
            frotisVaginalS.otrosFresco = _otrosFrescoController.text;
            frotisVaginalS.pruebaDeAminas = _pruebaDeAminasController.text;
            frotisVaginalS.celulasGuia1 = _celulasGuia1Controller.text;
            frotisVaginalS.ph = _phController.text;
            frotisVaginalS.trichonomasVaginales =
                _trichonomasVaginalesController.text;
            frotisVaginalS.pmn = _pmnController.text;
            frotisVaginalS.celulasGuia2 = _celulasGuia2Controller.text;
            frotisVaginalS.blastoconidias = _blastoconidiasController.text;
            frotisVaginalS.seudomicelios = _seudomiceliosController.text;
            frotisVaginalS.lactobacillus = _lactobacillusController.text;
            frotisVaginalS.gardnerellaSp = _gardnerellaSpController.text;
            frotisVaginalS.bacteroidesSp = _bacteroidesSpController.text;
            frotisVaginalS.mobilluncusSp = _mobilluncusSpController.text;
            frotisVaginalS.pmnx = _pmnxController.text;
            frotisVaginalS.intracelulares = _intracelularesController.text;
            frotisVaginalS.extracelulares = _extracelularesController.text;
            frotisVaginalS.observaciones = _observacionesController.text;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _buildTextField('otrosFresco ', _otrosFrescoController),
                _buildTextField('pruebaDeAminas ', _pruebaDeAminasController),
                _buildTextField('celulasGuia1 ', _celulasGuia1Controller),
                _buildTextField('ph ', _phController),
                _buildTextField(
                    'trichonomasVaginales ', _trichonomasVaginalesController),
                _buildTextField('pmn ', _pmnController),
                _buildTextField('celulasGuia2 ', _celulasGuia2Controller),
                _buildTextField('blastoconidias ', _blastoconidiasController),
                _buildTextField('seudomicelios ', _seudomiceliosController),
                _buildTextField('lactobacillus ', _lactobacillusController),
                _buildTextField('gardnerellaSp ', _gardnerellaSpController),
                _buildTextField('bacteroidesSp ', _bacteroidesSpController),
                _buildTextField('mobilluncusSp ', _mobilluncusSpController),
                _buildTextField('pmnx ', _pmnxController),
                _buildTextField('intracelulares ', _intracelularesController),
                _buildTextField('extracelulares ', _extracelularesController),
                _buildTextField('observaciones ', _observacionesController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
