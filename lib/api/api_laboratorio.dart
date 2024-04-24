// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laboratorioapp/models/configuracion_model.dart';
import 'package:laboratorioapp/models/coprologico.dart';
import 'package:laboratorioapp/models/examen_tipo1_model.dart';
import 'package:laboratorioapp/models/examenes.dart';
import 'package:laboratorioapp/models/hemograma_rayto.dart';
import 'package:laboratorioapp/models/hg_rayto.dart';
import 'package:laboratorioapp/models/paciente.dart';
import 'package:laboratorioapp/models/parcial_orina.dart';

import 'package:laboratorioapp/providers/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Paciente> getInfoPaciente(
  BuildContext context, {
  String identificacion = '',
}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getPaciente.php');
  final String bodyData = json.encode({
    'identificacion': identificacion,
  });
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosPaciente = json.decode(decodedResponse);
      if (datosPaciente['msg']) {
        return Paciente.fromJson(datosPaciente['data']);
      }
    } else {}
    return Paciente();
  } catch (e) {
    return Paciente(identificacion: 'Error');
  }
}

Future<List<Paciente>?> getPacientes(BuildContext context,
    {String criterio = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getPacientes.php');
  late final http.Response response;
  final String bodyData = json.encode({"criterio": criterio});
  try {
    response = criterio == ''
        ? await http.get(url)
        : await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      List<dynamic> datosPaciente = json.decode(response.body);
      List<Paciente> result =
          datosPaciente.map((p) => Paciente.fromJson(p)).toList();
      return result;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al obtener el listado: $e');

    return [];
  }
}

Future<List<Examenes>?> examenesPaciente(BuildContext context,
    {String criterio = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getExamenesPaciente.php');
  late final http.Response response;
  final String bodyData = json.encode({"criterio": criterio});
  try {
    response = criterio == ''
        ? await http.get(url)
        : await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      List<dynamic> datosPaciente = json.decode(response.body);
      List<Examenes> result =
          datosPaciente.map((p) => Examenes.fromJson(p)).toList();
      return result;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al obtener el listado: $e');

    return [];
  }
}

Future<HemogramaRayto> getHemogramaRayto(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getHemogramaRayto.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosHemograma = json.decode(decodedResponse);
      if (datosHemograma['msg']) {
        return HemogramaRayto.fromJson(datosHemograma['data']);
      }
    } else {
      return HemogramaRayto(identificacion: 'Error');
    }
    return HemogramaRayto(identificacion: 'Error');
  } catch (e) {
    return HemogramaRayto(identificacion: 'ErrorInternet');
  }
}

Future<HRayto> getHemogramaRaytoNew(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getHemogramaRaytoNew.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosHemograma = json.decode(decodedResponse);
      if (datosHemograma['msg']) {
        return HRayto.fromJson(datosHemograma['data']);
      }
    } else {}
    return HRayto(identificacion: 'Error');
  } catch (e) {
    return HRayto(identificacion: 'ErrorInternet');
  }
}

Future<ParcialOrina> getParcialOrina(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getParcialOrina.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosParcialOrina = json.decode(decodedResponse);
      if (datosParcialOrina['msg']) {
        return ParcialOrina.fromJson(datosParcialOrina['data']);
      }
    } else {}
    return ParcialOrina(identificacion: 'Error');
  } catch (e) {
    return ParcialOrina(identificacion: 'ErrorInternet');
  }
}

Future<Coprologico> getCoprologico(BuildContext context,
    {String identificacion = '', String fecha = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getCoprologico.php');
  final String bodyData =
      json.encode({'identificacion': identificacion, 'fecha': fecha});
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosCoprologico = json.decode(decodedResponse);
      if (datosCoprologico['msg']) {
        return Coprologico.fromJson(datosCoprologico['data']);
      }
    } else {
      return Coprologico(identificacion: 'Error');
    }
    return Coprologico(identificacion: 'Error');
  } catch (e) {
    return Coprologico(identificacion: 'ErrorInternet');
  }
}

Future<void> guardarHemograma(BuildContext context, HRayto hrayto) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...hrayto.toJson(), "tabla": "hemogramaRayto"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<void> guardarParcialOrina(
    BuildContext context, ParcialOrina parcialOrina) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...parcialOrina.toJson(), "tabla": "parcialOrina"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<void> guardarCoprologico(
    BuildContext context, Coprologico coprologico) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...coprologico.toJson(), "tabla": "coprologico"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}

Future<bool> _launchInBrowser(Uri url) async {
  bool result = false;
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    result = false;
    throw Exception('Could not launch $url');
  } else {
    result = true;
  }
  return result;
}

Future<void> printPDFFile(
    BuildContext context,
    String tabla,
    String info,
    String fileName,
    String identificacion,
    String fecha,
    String nombres) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  /* final Uri url = Uri.parse(
      '${urlProvider.url}printphp/print_examen.php?identificacion=$identificacion&fecha=$fecha&nombres=$nombres&tabla=$tabla&info=$info'); */
  String ile =
      '${urlProvider.url}listaExamenes.php?identificacion=$identificacion&fecha=$fecha&tabla=$tabla&info=$info&embedido=1&nombres=$nombres';
  print(ile);
  final Uri url = Uri.parse(ile);
  print(url);
  final bool result = await _launchInBrowser(url);
  print(result);
}

Future<bool> guardarConfiguracion(
    BuildContext context, ConfiguracionModel configuracion) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarConfiguracion.php');
  final String bodyData = configuracionToJson(configuracion);
  late final http.Response response;
  try {
    response = await http.post(url, body: bodyData);
    return response.statusCode == 200;
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
  return false;
}

Future<ConfiguracionModel> getConfiguracion(BuildContext context) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getConfiguracion.php');
  late final http.Response response;
  try {
    response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosConfiguracion = json.decode(decodedResponse);
      if (datosConfiguracion['msg']) {
        return ConfiguracionModel.fromJson(datosConfiguracion['data']);
      }
    } else {
      return ConfiguracionModel();
    }
  } catch (e) {
    print(e);
  }
  return ConfiguracionModel();
}

Future<ExamenTipo1> getTipo1(BuildContext context,
    {String identificacion = '',
    String fecha = '',
    String codexamen = ''}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}getTipo1.php');
  final String bodyData = json.encode({
    'identificacion': identificacion,
    'fecha': fecha,
    'codexamen': codexamen
  });
  late final http.Response response;
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosExamen = json.decode(decodedResponse);
      if (datosExamen['msg']) {
        return ExamenTipo1.fromJson(datosExamen['data']);
      }
    } else {
      return ExamenTipo1(identificacion: 'Error');
    }
  } catch (e) {
    print(e);
  }
  return ExamenTipo1(identificacion: 'Error');
}

Future<void> guardarTipo1(BuildContext context, ExamenTipo1 examen) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}guardarExamen.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...examen.toJson(), "tabla": "examen_tipo_1"});
  try {
    response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print('Error al enviar los datos del hemograma: $e');
  }
}
