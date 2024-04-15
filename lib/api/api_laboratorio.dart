// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laboratorioapp/models/examenes.dart';
import 'package:laboratorioapp/models/hemograma_rayto.dart';
import 'package:laboratorioapp/models/hg_rayto.dart';
import 'package:laboratorioapp/models/paciente.dart';
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

Future<HemogramaRayto> getHemogramaRayto(
  BuildContext context, {
  String ind = '',
}) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  Uri url = Uri.parse('${urlProvider.url}getHemogramaRayto.php');
  final String bodyData = json.encode({
    'ind': ind,
  });
  try {
    final response = await http.post(url, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datosHemograma = json.decode(decodedResponse);
      if (datosHemograma['msg']) {
        return HemogramaRayto.fromJson(datosHemograma['data']);
      }
    } else {}
    return HemogramaRayto(identificacion: 'Error');
  } catch (e) {
    return HemogramaRayto(identificacion: 'Error');
  }
}

Future<void> guardarHemograma(BuildContext context, HRayto hrayto) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse('${urlProvider.url}saveHemogramaRayto.php');
  late final http.Response response;
  final String bodyData = json.encode(hrayto.toJson());
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

Future<void> downloadPDFFile(
    BuildContext context,
    String urlprint,
    String fileName,
    String identificacion,
    String fecha,
    String nombres) async {
  final urlProvider = Provider.of<UrlProvider>(context, listen: false);
  final Uri url = Uri.parse(
      '${urlProvider.url}printphp/$urlprint.php?identificacion=$identificacion&fecha=$fecha&nombres=$nombres');
  final bool result = await _launchInBrowser(url);
  print(result);
}
