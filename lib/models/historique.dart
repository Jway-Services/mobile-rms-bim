


import 'user.dart';

class Historique {
  String? id;
  String? action;
  String? module;
  DateTime? date;
  User? user;

  Historique({
    this.id,
    this.action,
    this.module,
    this.date,
    this.user,
  });

  factory Historique.fromJson(Map<String, dynamic> json) => Historique(
    id: json["id"].toString(),
    action: json["action"],
    module: json["module"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}