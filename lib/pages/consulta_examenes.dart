// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/examenes.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/examenes.dart';

class ConsultaExamenes extends StatefulWidget {
  final String paciente;
  final String nombres;

  const ConsultaExamenes({
    super.key,
    required this.paciente,
    required this.nombres,
  });

  @override
  State<ConsultaExamenes> createState() => _ConsultaExamenesState();
}

String formatDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final List<String> weekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  final monthNames = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  return '${weekdays[dateTime.weekday - 1]} ${dateTime.day} de ${monthNames[dateTime.month - 1]} de ${dateTime.year}';
}

class _ConsultaExamenesState extends State<ConsultaExamenes> {
  List<Examenes> examenes = [];
  List<Examenes> examenesFilter = [];
  List<String> listaFechas = [];
  FToast fToast = FToast();
  String fechae = '2012-08-23';
  late final List<DropdownMenuItem> _fechas;
  bool mirando = false;
  @override
  void initState() {
    super.initState();
    fToast.init(context);
    //  pacientes = await getPacientes(context) as List<Paciente>;
    setState(() => mirando = !mirando);
    examenesPaciente(context, criterio: widget.paciente).then((value) {
      if (value != null) {
        examenes = value;
        examenesFilter = examenes;
        examenesFilter = examenes
            .where((Examenes element) => element.fecha.contains('-')
                ? element.fecha == fechae
                : element.fecha != '')
            .toList();
        setState(() {});
        setState(() => mirando = !mirando);
        Set<String> listafechas =
            Set.from(examenes.map((Examenes examen) => examen.fecha));
        print(listafechas);
        listaFechas.addAll(listafechas);
        listaFechas = ['Fecha del o de los examenes', 'Todos'] + listaFechas;
        int idx = 0;
        _fechas = listaFechas.map((e) {
          idx++;
          return DropdownMenuItem(
            value: e.contains('Fecha') ? '' : e,
            enabled: e != '',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e,
                  style: TextStyle(
                    color: e.contains('Fecha') || e.contains('Todos')
                        ? Colors.grey
                        : idx % 2 == 0
                            ? Colors.green
                            : Colors.amber,
                  ),
                ),
                Text(
                  e.contains('-') ? formatDate(e) : '',
                  style: const TextStyle(
                      fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          );
        }).toList();
      } else {
        showToastB(fToast, 'Error en el sevidor');
      }
      setState(() {});
    });
  }

  String imageLab(String examen) {
    String result = '';
    if (examen.toLowerCase().contains('hema')) {
      result = 'images/hemat.png';
      // ignore: curly_braces_in_flow_control_structures
    } else if (examen.toLowerCase().contains('coles') ||
        examen.toLowerCase().contains('trigli') ||
        examen.toLowerCase().contains('lipi'))
    // ignore: curly_braces_in_flow_control_structures
    {
      result = 'images/hdl.png';
    } else {
      result = 'images/lab.png';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        title: Text(
          widget.nombres,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
      body: examenes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: examenesFilter.length + 1,
              itemBuilder: (context, index) {
                late String identificacion;
                late String examen;
                late String codexamen;
                late String fecha;
                late String bacteriologo;
                late String doctor;
                int indexx = index - 1;
                if (index == 0) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        18.0,
                      ),
                      child: DropdownButton(
                        value: fechae,
                        items: _fechas,
                        onChanged: (value) {
                          fechae = value;
                          examenesFilter = examenes
                              .where((element) => value.contains('-')
                                  ? element.fecha == fechae
                                  : element.fecha != '')
                              .toList();
                          setState(() {});
                        },
                      ),
                    ),
                  );
                } else {
                  identificacion = examenesFilter[indexx].identificacion;
                  examen = examenesFilter[indexx].examen;
                  codexamen = examenesFilter[indexx].codexamen;
                  fecha = examenesFilter[indexx].fecha;
                  bacteriologo = examenesFilter[indexx].bacteriologo;
                  doctor = examenesFilter[indexx].doctor;
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25, // Ajusta el tamaño del avatar
                        backgroundImage: AssetImage(imageLab(examen)),
                      ),
                      trailing: !mirando
                          ? IconButton(
                              onPressed: () async {
                                setState(() {
                                  mirando = !mirando;
                                });
                                await viewExam(
                                    context, codexamen, identificacion, fecha);
                                setState(() {
                                  mirando = !mirando;
                                });
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.blue,
                              ),
                            )
                          : const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                      title: Text(
                        examen,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fecha,
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Bacteriólogo: $bacteriologo',
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'C.C.: $doctor',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> viewExam(BuildContext context, String codigo,
      String identificacion, String fecha) async {
    if (codigo == '3000' || codigo == '3001') {
      await hemogramas(context, identificacion, fecha, widget.nombres, fToast);
    }
  }
}
