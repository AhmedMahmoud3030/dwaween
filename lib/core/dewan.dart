// To parse this JSON data, do
//
//     final dawawenBody = dawawenBodyFromJson(jsonString);

import 'dart:convert';

DawawenBody dawawenBodyFromJson(Map<String, dynamic> str) =>
    DawawenBody.fromJson(str);

String dawawenBodyToJson(DawawenBody data) => json.encode(data.toJson());

class DawawenBody {
  List<Dawawen>? dawawen;
  // List<Kenashat>? kenashat;

  DawawenBody({
    this.dawawen,
    // this.kenashat,
  });

  DawawenBody copyWith({
    List<Dawawen>? dawawen,
    // List<Kenashat>? kenashat,
  }) =>
      DawawenBody(
        dawawen: dawawen ?? this.dawawen,
        // kenashat: kenashat ?? this.kenashat,
      );

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

  Map<String, dynamic> toJson() => {
        "Dawawen": dawawen == null
            ? []
            : List<dynamic>.from(dawawen!.map((x) => x.toJson())),
        // "Kenashat": kenashat == null
        // ? []
        // : List<dynamic>.from(kenashat!.map((x) => x.toJson())),
      };
}

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

  Dawawen copyWith({
    String? id,
    String? name,
    String? nameT,
    String? dec,
    String? type,
    List<Kenashat>? kasaed,
  }) =>
      Dawawen(
        id: id ?? this.id,
        name: name ?? this.name,
        nameT: nameT ?? this.nameT,
        dec: dec ?? this.dec,
        type: type ?? this.type,
        kasaed: kasaed ?? this.kasaed,
      );

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameT": nameT,
        "dec": dec,
        "type": type,
        "kasaed": kasaed == null
            ? []
            : List<dynamic>.from(kasaed!.map((x) => x.toJson())),
      };
}

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

  Kenashat copyWith({
    String? id,
    Type? type,
    String? name,
    String? nameT,
    String? purpose,
    String? kaseyda,
    String? kaseydaT,
    String? letter,
  }) =>
      Kenashat(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        nameT: nameT ?? this.nameT,
        purpose: purpose ?? this.purpose,
        kaseyda: kaseyda ?? this.kaseyda,
        kaseydaT: kaseydaT ?? this.kaseydaT,
        letter: letter ?? this.letter,
      );

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "name": name,
        "nameT": nameT,
        "purpose": purpose,
        "kaseyda": kaseyda,
        "kaseydaT": kaseydaT,
        "letter": letter,
      };
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
