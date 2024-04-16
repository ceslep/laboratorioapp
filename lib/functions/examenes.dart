import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/hemograma_rayto.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/hemograma_rayto.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<void> hemogramas(BuildContext context, String identificacion,
    String fecha, String nombres, FToast fToast) async {
  getHemogramaRayto(context, identificacion: identificacion, fecha: fecha)
      .then((HemogramaRayto value) async {
    HemogramaRayto hemograma = value;
    if (hemograma.identificacion != '' && hemograma.identificacion != 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewHemogramaRayto(
            hemograma: hemograma,
            identificacion: identificacion,
            fecha: fecha,
            nombres: nombres,
          ),
        ),
      );
    } else if (hemograma.identificacion == 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewHemogramaRayto(
            hemograma: HemogramaRayto(),
            identificacion: identificacion,
            fecha: fecha,
            nombres: nombres,
          ),
        ),
      );
    } else {
      showToastB(
        fToast,
        'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
        bacgroundColor: Colors.red,
        frontColor: Colors.yellow,
        icon: Icon(
          MdiIcons.networkOff,
          color: Colors.yellow,
        ),
        milliseconds: 10,
      );
    }
  });
}
