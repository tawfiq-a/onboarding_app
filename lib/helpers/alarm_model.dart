class AlarmModel {
  final int id;
  DateTime time;
  bool isOn;

  AlarmModel({
    required this.id,
    required this.time,
    this.isOn = true,
  });
}