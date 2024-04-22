// To parse this JSON data, do
//
//     final configuracion = configuracionFromJson(jsonString);

import 'dart:convert';

ConfiguracionModel configuracionFromJson(String str) =>
    ConfiguracionModel.fromJson(json.decode(str));

String configuracionToJson(ConfiguracionModel data) =>
    json.encode(data.toJson());

class ConfiguracionModel {
  final String? id;
  final String? nit;
  final String? nombreLaboratorio;
  final String? direccionLaboratorio;
  final String? telefonosLaboratorio;
  final String? correoLaboratorio;
  final String? webLaboratorio;
  final String? bacteriologoLaboratorio;
  final String? tarjetaPLaboratorio;
  final String? urFirmaLaboratorio;
  final String? urlLogoLaboratorio;

  ConfiguracionModel({
    this.id,
    this.nit,
    this.nombreLaboratorio,
    this.direccionLaboratorio,
    this.telefonosLaboratorio,
    this.correoLaboratorio,
    this.webLaboratorio,
    this.bacteriologoLaboratorio,
    this.tarjetaPLaboratorio,
    this.urFirmaLaboratorio,
    this.urlLogoLaboratorio,
  });

  factory ConfiguracionModel.fromJson(Map<String, dynamic> json) =>
      ConfiguracionModel(
        id: json["id"].toString(),
        nit: json["nit"].toString(),
        nombreLaboratorio: json["nombreLaboratorio"].toString(),
        direccionLaboratorio: json["direccionLaboratorio"].toString(),
        telefonosLaboratorio: json["telefonosLaboratorio"].toString(),
        correoLaboratorio: json["correoLaboratorio"].toString(),
        webLaboratorio: json["webLaboratorio"].toString(),
        bacteriologoLaboratorio: json["bacteriologoLaboratorio"].toString(),
        tarjetaPLaboratorio: json["tarjetaPLaboratorio"].toString(),
        urFirmaLaboratorio: json["urFirmaLaboratorio"].toString(),
        urlLogoLaboratorio: json["urlLogoLaboratorio"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nit": nit,
        "nombreLaboratorio": nombreLaboratorio,
        "direccionLaboratorio": direccionLaboratorio,
        "telefonosLaboratorio": telefonosLaboratorio,
        "correoLaboratorio": correoLaboratorio,
        "webLaboratorio": webLaboratorio,
        "bacteriologoLaboratorio": bacteriologoLaboratorio,
        "tarjetaPLaboratorio": tarjetaPLaboratorio,
        "urFirmaLaboratorio": urFirmaLaboratorio,
        "urlLogoLaboratorio": urlLogoLaboratorio,
      };
}
