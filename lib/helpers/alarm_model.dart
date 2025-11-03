

class AlarmModel {
  final int id;
  DateTime time;
  bool isOn;


  double? targetLatitude;
  double? targetLongitude;
  double radiusMeters;

  AlarmModel({
    required this.id,
    required this.time,
    this.isOn = true,

    this.targetLatitude,
    this.targetLongitude,
    this.radiusMeters = 1000.0,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time.toIso8601String(),
      'isOn': isOn,

      'targetLatitude': targetLatitude,
      'targetLongitude': targetLongitude,
      'radiusMeters': radiusMeters,
    };
  }


  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'] as int,
      time: DateTime.parse(json['time'] as String),
      isOn: json['isOn'] as bool,


      targetLatitude: json['targetLatitude'] as double?,
      targetLongitude: json['targetLongitude'] as double?,
      radiusMeters: json['radiusMeters'] as double? ?? 1000.0,
    );
  }
}