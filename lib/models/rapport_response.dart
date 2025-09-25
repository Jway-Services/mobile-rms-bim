import 'package:bim/models/personel.dart';

class RapportResponse {
  final int? total;
  final List<Personel>? personnel;

  RapportResponse({this.total, this.personnel});

  factory RapportResponse.fromJson(Map<String, dynamic> json) {
    return RapportResponse(
      total: json['total'],
      personnel: (json['personnel'] as List<dynamic>?)
          ?.map((e) => Personel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }


}