import 'dart:convert';

class DawawenBody {
   List<Dawawen> dawawen;

  DawawenBody({
    required this.dawawen,
  });

  DawawenBody copyWith({
    List<Dawawen>? dawawen,
  }) =>
      DawawenBody(
        dawawen: dawawen ?? this.dawawen,
      );

  factory DawawenBody.fromRawJson(String str) =>
      DawawenBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DawawenBody.fromJson(Map<String, dynamic> json) => DawawenBody(
        dawawen:
            List<Dawawen>.from(json["Dawawen"].map((x) => Dawawen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Dawawen": List<dynamic>.from(dawawen.map((x) => x.toJson())),
      };
}

class Dawawen {
   String id;
   String name;
   String nameT;
   String dec;
   String type;
   List<Kenashat> kasaed;

  Dawawen({
    required this.id,
    required this.name,
    required this.nameT,
    required this.dec,
    required this.type,
    required this.kasaed,
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

  factory Dawawen.fromRawJson(String str) => Dawawen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dawawen.fromJson(Map<String, dynamic> json) => Dawawen(
        id: json["id"],
        name: json["name"],
        nameT: json["nameT"],
        dec: json["dec"],
        type: json["type"],
        kasaed: List<Kenashat>.from(
            json["kasaed"].map((x) => Kenashat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameT": nameT,
        "dec": dec,
        "type": type,
        "kasaed": List<dynamic>.from(kasaed.map((x) => x.toJson())),
      };
}

class Kenashat {
   String id;
   String purpose;
   String type;
   String name;
   String nameT;
   String kaseyda;
   String kaseydaT;
   String letter;

  Kenashat({
    required this.id,
    required this.purpose,
    required this.type,
    required this.name,
    required this.nameT,
    required this.kaseyda,
    required this.kaseydaT,
    required this.letter,
  });

  Kenashat copyWith({
    String? id,
    String? purpose,
    String? type,
    String? name,
    String? nameT,
    String? kaseyda,
    String? kaseydaT,
    String? letter,
  }) =>
      Kenashat(
        id: id ?? this.id,
        purpose: purpose ?? this.purpose,
        type: type ?? this.type,
        name: name ?? this.name,
        nameT: nameT ?? this.nameT,
        kaseyda: kaseyda ?? this.kaseyda,
        kaseydaT: kaseydaT ?? this.kaseydaT,
        letter: letter ?? this.letter,
      );

  factory Kenashat.fromRawJson(String str) =>
      Kenashat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kenashat.fromJson(Map<String, dynamic> json) => Kenashat(
        id: json["id"],
        purpose: json["purpose"],
        type: json["type"],
        name: json["name"],
        nameT: json["nameT"],
        kaseyda: json["kaseyda"],
        kaseydaT: json["kaseydaT"],
        letter: json["letter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "purpose": purpose,
        "type": type,
        "name": name,
        "nameT": nameT,
        "kaseyda": kaseyda,
        "kaseydaT": kaseydaT,
        "letter": letter,
      };
}
