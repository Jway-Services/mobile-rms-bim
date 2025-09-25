
import 'data_record.dart';

class DashboardData {
  List<DataRecord> departement;
  List<DataRecord> personnel;
  List<DataRecord> region;
  List<DataRecord> hour;

  DashboardData({
    required this.departement,
    required this.personnel,
    required this.region,
    required this.hour
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      departement: (json['departement'] as List)
          .map((e) => DataRecord.fromJson(e))
          .toList(),
      personnel: (json['personnel'] as List)
          .map((e) => DataRecord.fromJson(e))
          .toList(),
      region: (json['region'] as List)
          .map((e) => DataRecord.fromJson(e))
          .toList(),
      hour: (json['hour'] as List)
          .map((e) => DataRecord.fromJson(e))
          .toList(),
    );
  }
}
