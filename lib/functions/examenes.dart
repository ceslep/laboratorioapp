// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laboratorioapp/api/api_laboratorio.dart';
import 'package:laboratorioapp/functions/show_toast.dart';
import 'package:laboratorioapp/models/hemograma_rayto.dart';
import 'package:laboratorioapp/models/hg_rayto.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/models/parcial_orina.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/hemograma_rayto.dart';
import 'package:laboratorioapp/pages/view_examenes/form_hemograma/hemograma_rayto_new.dart';
import 'package:laboratorioapp/pages/view_examenes/parcialOrina/parcial_orina.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<void> hemogramas(BuildContext context, Paciente paciente, String fecha,
    FToast fToast) async {
  getHemogramaRayto(context,
          identificacion: paciente.identificacion!, fecha: fecha)
      .then((HemogramaRayto value) async {
    HemogramaRayto hemograma = value;
    if (hemograma.identificacion != '' && hemograma.identificacion != 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewHemogramaRayto(
            hemograma: hemograma,
            fecha: fecha,
            paciente: paciente,
          ),
        ),
      );
      return true;
    } else if (hemograma.identificacion == 'Error') {
      getHemogramaRaytoNew(context,
              identificacion: paciente.identificacion!, fecha: fecha)
          .then(
        (HRayto value) async {
          HRayto hemograma = value;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewHemogramaRaytoNew(
                paciente: paciente,
                hemograma: hemograma,
                fecha: fecha,
              ),
            ),
          );
        },
      );
      return true;
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

Future<bool> hemogramas2(BuildContext context, Paciente paciente, String fecha,
    FToast fToast) async {
  HemogramaRayto hemograma = await getHemogramaRayto(context,
      identificacion: paciente.identificacion!, fecha: fecha);

  if (hemograma.identificacion != '' && hemograma.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewHemogramaRayto(
          hemograma: hemograma,
          fecha: fecha,
          paciente: paciente,
        ),
      ),
    );
    return true;
  } else if (hemograma.identificacion == 'Error') {
    HRayto hemograma = await getHemogramaRaytoNew(context,
        identificacion: paciente.identificacion!, fecha: fecha);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewHemogramaRaytoNew(
          paciente: paciente,
          hemograma: hemograma,
          fecha: fecha,
        ),
      ),
    );

    return true;
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
  return false;
}

Future<void> parcialOrina(BuildContext context, Paciente paciente, String fecha,
    FToast fToast) async {
  getParcialOrina(context,
          identificacion: paciente.identificacion!, fecha: fecha)
      .then((ParcialOrina value) async {
    ParcialOrina parcialOrina = value;
    if (parcialOrina.identificacion != '' &&
        parcialOrina.identificacion != 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewParcialOrina(
            parcialOrina: parcialOrina,
            fecha: fecha,
            paciente: paciente,
          ),
        ),
      );
    } else if (parcialOrina.identificacion == 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewParcialOrina(
            paciente: paciente,
            parcialOrina: ParcialOrina(),
            fecha: fecha,
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

Future<bool> parcialOrina2(BuildContext context, Paciente paciente,
    String fecha, FToast fToast) async {
  ParcialOrina parcialOrina = await getParcialOrina(context,
      identificacion: paciente.identificacion!, fecha: fecha);

  if (parcialOrina.identificacion != '' &&
      parcialOrina.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewParcialOrina(
          parcialOrina: parcialOrina,
          fecha: fecha,
          paciente: paciente,
        ),
      ),
    );
    return true;
  } else if (parcialOrina.identificacion == 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewParcialOrina(
          paciente: paciente,
          parcialOrina: ParcialOrina(),
          fecha: fecha,
        ),
      ),
    );
    return true;
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
  return false;
}
