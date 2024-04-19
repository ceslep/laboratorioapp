// To parse this JSON data, do
//
//     final coprologico = coprologicoFromJson(jsonString);

import 'dart:convert';

Coprologico coprologicoFromJson(String str) =>
    Coprologico.fromJson(json.decode(str));

String coprologicoToJson(Coprologico data) => json.encode(data.toJson());

class Coprologico {
  final String? ind;
  final String? identificacion;
  final DateTime? fecha;
  final String? consistencia;
  final String? color;
  final String? sangre;
  final String? moco;
  final String? otrosMacroscopicos;
  final String? ph;
  final String? endamoebaHistoliticaQuistes;
  final String? endamoebaColiQuistes;
  final String? endolimaxQuistes;
  final String? iodamoebaQuistes;
  final String? giardaLambliaQuistes;
  final String? chilomastixMesniliQuistes;
  final String? trichomonaHominisQuistes;
  final String? balantidiumColiQuistes;
  final String? endamoebaHistoliticaTrofozoitos;
  final String? endamoebaColiTrofozoitos;
  final String? endolimaxTrofozoitos;
  final String? iodamoebaTrofozoitos;
  final String? giardaLambliaTrofozoitos;
  final String? chilomastixMesniliTrofozoitos;
  final String? trichomonaHominisTrofozoitos;
  final String? balantidiumColiTrofozoitos;
  final String? blastocystisHominisQuistes;
  final String? blastocystisHominisTrofozoitos;
  final String? ascaris;
  final String? tricocefalos;
  final String? uncinaria;
  final String? teniaSaginata;
  final String? teniaSolium;
  final String? himenolepsis;
  final String? strongiloidesLarva;
  final String? oxiurosHuevos;
  final String? sangreOculta;
  final String? lecucocitos;
  final String? observaciones;
  final String? doctor;
  final String? fechahora;

  Coprologico({
    this.ind,
    this.identificacion,
    this.fecha,
    this.consistencia,
    this.color,
    this.sangre,
    this.moco,
    this.otrosMacroscopicos,
    this.ph,
    this.endamoebaHistoliticaQuistes,
    this.endamoebaColiQuistes,
    this.endolimaxQuistes,
    this.iodamoebaQuistes,
    this.giardaLambliaQuistes,
    this.chilomastixMesniliQuistes,
    this.trichomonaHominisQuistes,
    this.balantidiumColiQuistes,
    this.endamoebaHistoliticaTrofozoitos,
    this.endamoebaColiTrofozoitos,
    this.endolimaxTrofozoitos,
    this.iodamoebaTrofozoitos,
    this.giardaLambliaTrofozoitos,
    this.chilomastixMesniliTrofozoitos,
    this.trichomonaHominisTrofozoitos,
    this.balantidiumColiTrofozoitos,
    this.blastocystisHominisQuistes,
    this.blastocystisHominisTrofozoitos,
    this.ascaris,
    this.tricocefalos,
    this.uncinaria,
    this.teniaSaginata,
    this.teniaSolium,
    this.himenolepsis,
    this.strongiloidesLarva,
    this.oxiurosHuevos,
    this.sangreOculta,
    this.lecucocitos,
    this.observaciones,
    this.doctor,
    this.fechahora,
  });

  factory Coprologico.fromJson(Map<String, dynamic> json) => Coprologico(
        ind: json["ind"].toString(),
        identificacion: json["identificacion"].toString(),
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        consistencia: json["consistencia"].toString(),
        color: json["color"].toString(),
        sangre: json["sangre"].toString(),
        moco: json["moco"].toString(),
        otrosMacroscopicos: json["otros_macroscopicos"].toString(),
        ph: json["ph"].toString(),
        endamoebaHistoliticaQuistes:
            json["endamoeba_histolitica_quistes"].toString(),
        endamoebaColiQuistes: json["endamoeba_coli_quistes"].toString(),
        endolimaxQuistes: json["endolimax_quistes"].toString(),
        iodamoebaQuistes: json["iodamoeba_quistes"].toString(),
        giardaLambliaQuistes: json["giarda_lamblia_quistes"].toString(),
        chilomastixMesniliQuistes:
            json["chilomastix_mesnili_quistes"].toString(),
        trichomonaHominisQuistes: json["trichomona_hominis_quistes"].toString(),
        balantidiumColiQuistes: json["balantidium_coli_quistes"].toString(),
        endamoebaHistoliticaTrofozoitos:
            json["endamoeba_histolitica_trofozoitos"].toString(),
        endamoebaColiTrofozoitos: json["endamoeba_coli_trofozoitos"].toString(),
        endolimaxTrofozoitos: json["endolimax_trofozoitos"].toString(),
        iodamoebaTrofozoitos: json["iodamoeba_trofozoitos"].toString(),
        giardaLambliaTrofozoitos: json["giarda_lamblia_trofozoitos"].toString(),
        chilomastixMesniliTrofozoitos:
            json["chilomastix_mesnili_trofozoitos"].toString(),
        trichomonaHominisTrofozoitos:
            json["trichomona_hominis_trofozoitos"].toString(),
        balantidiumColiTrofozoitos:
            json["balantidium_coli_trofozoitos"].toString(),
        blastocystisHominisQuistes:
            json["Blastocystis_hominis_quistes"].toString(),
        blastocystisHominisTrofozoitos:
            json["Blastocystis_hominis_trofozoitos"].toString(),
        ascaris: json["ascaris"].toString(),
        tricocefalos: json["tricocefalos"].toString(),
        uncinaria: json["uncinaria"].toString(),
        teniaSaginata: json["tenia_saginata"].toString(),
        teniaSolium: json["tenia_solium"].toString(),
        himenolepsis: json["himenolepsis"].toString(),
        strongiloidesLarva: json["strongiloides_larva"].toString(),
        oxiurosHuevos: json["oxiuros_huevos"].toString(),
        sangreOculta: json["sangre_oculta"].toString(),
        lecucocitos: json["lecucocitos"].toString(),
        observaciones: json["observaciones"].toString(),
        doctor: json["doctor"].toString(),
        fechahora: json["fechahora"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "ind": ind,
        "identificacion": identificacion,
        "fecha":
            "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "consistencia": consistencia,
        "color": color,
        "sangre": sangre,
        "moco": moco,
        "otros_macroscopicos": otrosMacroscopicos,
        "ph": ph,
        "endamoeba_histolitica_quistes": endamoebaHistoliticaQuistes,
        "endamoeba_coli_quistes": endamoebaColiQuistes,
        "endolimax_quistes": endolimaxQuistes,
        "iodamoeba_quistes": iodamoebaQuistes,
        "giarda_lamblia_quistes": giardaLambliaQuistes,
        "chilomastix_mesnili_quistes": chilomastixMesniliQuistes,
        "trichomona_hominis_quistes": trichomonaHominisQuistes,
        "balantidium_coli_quistes": balantidiumColiQuistes,
        "endamoeba_histolitica_trofozoitos": endamoebaHistoliticaTrofozoitos,
        "endamoeba_coli_trofozoitos": endamoebaColiTrofozoitos,
        "endolimax_trofozoitos": endolimaxTrofozoitos,
        "iodamoeba_trofozoitos": iodamoebaTrofozoitos,
        "giarda_lamblia_trofozoitos": giardaLambliaTrofozoitos,
        "chilomastix_mesnili_trofozoitos": chilomastixMesniliTrofozoitos,
        "trichomona_hominis_trofozoitos": trichomonaHominisTrofozoitos,
        "balantidium_coli_trofozoitos": balantidiumColiTrofozoitos,
        "Blastocystis_hominis_quistes": blastocystisHominisQuistes,
        "Blastocystis_hominis_trofozoitos": blastocystisHominisTrofozoitos,
        "ascaris": ascaris,
        "tricocefalos": tricocefalos,
        "uncinaria": uncinaria,
        "tenia_saginata": teniaSaginata,
        "tenia_solium": teniaSolium,
        "himenolepsis": himenolepsis,
        "strongiloides_larva": strongiloidesLarva,
        "oxiuros_huevos": oxiurosHuevos,
        "sangre_oculta": sangreOculta,
        "lecucocitos": lecucocitos,
        "observaciones": observaciones,
        "doctor": doctor,
        "fechahora": fechahora,
      };
}
