class WeekOff {
  final int id;
  final String name;
  final String effectiveDate;
  final String description;
  final String createdDate;
  final String updatedDate;

  WeekOff({
    required this.id,
    required this.name,
    required this.effectiveDate,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
  });

  // Factory constructor to create a WeekOff object from JSON
  factory WeekOff.fromJson(Map<String, dynamic> json) {
    return WeekOff(
      id: json['id'],
      name: json['name'],
      effectiveDate: json['effective_date'],
      description: json['description'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
    );
  }

  // Method to convert a WeekOff object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'effective_date': effectiveDate,
      'description': description,
      'created_date': createdDate,
      'updated_date': updatedDate,
    };
  }
}
