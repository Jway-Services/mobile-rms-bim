import 'package:bim/config.dart';

class Personel {
  final int? id;
  final String? nom;
  final String? prenom;
  final String? profile;
  final int? nbRepas;
  final List<DateTime>? historiques;

  Personel({
    this.id,
    this.nom,
    this.prenom,
    this.profile,
    this.nbRepas,
    this.historiques
  });

  String get fullName{
    return "${nom} ${prenom}";
  }

  factory Personel.fromJson(Map<String, dynamic> json) {
    return Personel(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      profile: json['profile'],
      nbRepas: json['nbRepas'],
      historiques:json['historiques']==null?null:(json['historiques']as List).map((d)=>DateTime.parse(d)).toList()
    );
  }

  String get fullImageUrl{
    return "$imageBaseUrl$profile";
  }


}
