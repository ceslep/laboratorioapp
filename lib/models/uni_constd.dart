// To parse this JSON data, do
//
//     final uniConst = uniConstFromJson(jsonString);

import 'dart:convert';

UniConst uniConstFromJson(String str) => UniConst.fromJson(json.decode(str));

String uniConstToJson(UniConst data) => json.encode(data.toJson());

class UniConst {
  final String? unidades;
  final String? constante;

  UniConst({
    this.unidades,
    this.constante,
  });

  factory UniConst.fromJson(Map<String, dynamic> json) => UniConst(
        unidades: json["unidades"] ? json['unidades'] : '',
        constante: json["constante"] ? json["constante"] : '',
      );

  Map<String, dynamic> toJson() => {
        "unidades": unidades,
        "constante": constante,
      };
}
