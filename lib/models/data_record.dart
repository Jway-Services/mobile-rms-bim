class DataRecord {
  final String? name;
  final int value;

  DataRecord({this.name, required this.value});

  factory DataRecord.fromJson(Map<String, dynamic> json) {
    return DataRecord(
      name: json['name'],
      value: json['value'],
    );
  }
}