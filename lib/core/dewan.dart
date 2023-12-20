// To parse this JSON data, do
//
//     final dawawenBody = dawawenBodyFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

DawawenBody dawawenBodyFromJson(Map<String, dynamic> str) =>
    DawawenBody.fromJson(str);

@JsonSerializable()
class DawawenBody {
  List<Dawawen>? dawawen;
  List<Kenashat>? kenashat;

  DawawenBody({
    this.dawawen,
    this.kenashat,
  });

  factory DawawenBody.fromJson(Map<String, dynamic> json) => DawawenBody(
        dawawen: json["Dawawen"] == null
            ? []
            : List<Dawawen>.from(
                json["Dawawen"]!.map((x) => Dawawen.fromJson(x))),
        // kenashat: json["Kenashat"] == null
        //     ? []
        //     : List<Kenashat>.from(
        //         json["Kenashat"]!.map((x) => Kenashat.fromJson(x))),
      );
}

@JsonSerializable()
class Dawawen {
  String? id;
  String? name;
  String? nameT;
  String? dec;
  String? type;
  List<Kenashat>? kasaed;

  Dawawen({
    this.id,
    this.name,
    this.nameT,
    this.dec,
    this.type,
    this.kasaed,
  });

  factory Dawawen.fromJson(Map<String, dynamic> json) => Dawawen(
        id: json["id"],
        name: json["name"],
        nameT: json["nameT"],
        dec: json["dec"],
        type: json["type"],
        kasaed: json["kasaed"] == null
            ? []
            : List<Kenashat>.from(
                json["kasaed"]!.map((x) => Kenashat.fromJson(x))),
      );
}

@JsonSerializable()
class Kenashat {
  String? id;
  Type? type;
  String? name;
  String? nameT;
  String? purpose;
  String? kaseyda;
  String? kaseydaT;
  String? letter;

  Kenashat({
    this.id,
    this.type,
    this.name,
    this.nameT,
    this.purpose,
    this.kaseyda,
    this.kaseydaT,
    this.letter,
  });

  factory Kenashat.fromJson(Map<String, dynamic> json) => Kenashat(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        nameT: json["nameT"],
        purpose: json["purpose"],
        kaseyda: json["kaseyda"],
        kaseydaT: json["kaseydaT"],
        letter: json["letter"],
      );
}

enum Type { KASEYDA, KENASH }

final typeValues = EnumValues({"Kaseyda": Type.KASEYDA, "Kenash": Type.KENASH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
