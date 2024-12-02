class Shift {
  final int id;
  final String name;
  final String checkInTime;
  final String checkOutTime;
  final int breakMinute;
  final String totalHour;

  Shift({
    required this.id,
    required this.name,
    required this.checkInTime,
    required this.checkOutTime,
    required this.breakMinute,
    required this.totalHour,
  });

  // Factory constructor to create a Shift object from JSON
  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      name: json['name'],
      checkInTime: json['check_in_time'],
      checkOutTime: json['check_out_time'],
      breakMinute: json['break_minute'],
      totalHour: json['total_hour'],
    );
  }

  // Method to convert a Shift object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'check_in_time': checkInTime,
      'check_out_time': checkOutTime,
      'break_minute': breakMinute,
      'total_hour': totalHour,
    };
  }
}
