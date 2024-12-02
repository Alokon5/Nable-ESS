import 'dart:convert';

// Parse JSON to a list of StaffSalaryModel
List<StaffSalaryModel> staffSalaryModelFromJson(String str) =>
    List<StaffSalaryModel>.from(
      json.decode(str).map((x) => StaffSalaryModel.fromJson(x)),
    );

// Serialize StaffSalaryModel list to JSON
String staffSalaryModelToJson(List<StaffSalaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffSalaryModel {
  int id;
  String monthlySalary;
  DateTime salaryMonth;
  int totalDays;
  int weekOff;
  int holiday;
  int absent;
  int presentDays;
  int payableDays;
  String currentSalary;
  String addition;
  String additionRemark;
  String deduction;
  String deductionRemark;
  String netCurrentSalary;
  String status;
  DateTime createdDate;
  DateTime updatedDate;
  Staff? staff; // Nullable Staff object

  StaffSalaryModel({
    required this.id,
    required this.monthlySalary,
    required this.salaryMonth,
    required this.totalDays,
    required this.weekOff,
    required this.holiday,
    required this.absent,
    required this.presentDays,
    required this.payableDays,
    required this.currentSalary,
    required this.addition,
    required this.additionRemark,
    required this.deduction,
    required this.deductionRemark,
    required this.netCurrentSalary,
    required this.status,
    required this.createdDate,
    required this.updatedDate,
    this.staff,
  });

  factory StaffSalaryModel.fromJson(Map<String, dynamic> json) {
    return StaffSalaryModel(
      id: json["id"] ?? 0,
      monthlySalary: json["monthly_salary"] ?? "",
      salaryMonth: DateTime.parse(json["salary_month"] ?? DateTime.now().toIso8601String()),
      totalDays: json["total_days"] ?? 0,
      weekOff: json["week_off"] ?? 0,
      holiday: json["holiday"] ?? 0,
      absent: json["absent"] ?? 0,
      presentDays: json["present_days"] ?? 0,
      payableDays: json["payable_days"] ?? 0,
      currentSalary: json["current_salary"] ?? "",
      addition: json["addition"] ?? "",
      additionRemark: json["addition_remark"] ?? "",
      deduction: json["deduction"] ?? "",
      deductionRemark: json["deduction_remark"] ?? "",
      netCurrentSalary: json["net_current_salary"] ?? "",
      status: json["status"] ?? "",
      createdDate: DateTime.parse(json["created_date"] ?? DateTime.now().toIso8601String()),
      updatedDate: DateTime.parse(json["updated_date"] ?? DateTime.now().toIso8601String()),
      staff: json["staff"] != null && json["staff"] is Map<String, dynamic>
          ? Staff.fromJson(json["staff"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "monthly_salary": monthlySalary,
        "salary_month": salaryMonth.toIso8601String(),
        "total_days": totalDays,
        "week_off": weekOff,
        "holiday": holiday,
        "absent": absent,
        "present_days": presentDays,
        "payable_days": payableDays,
        "current_salary": currentSalary,
        "addition": addition,
        "addition_remark": additionRemark,
        "deduction": deduction,
        "deduction_remark": deductionRemark,
        "net_current_salary": netCurrentSalary,
        "status": status,
        "created_date": createdDate.toIso8601String(),
        "updated_date": updatedDate.toIso8601String(),
        "staff": staff?.toJson(),
      };
}

class Staff {
  int id;
  String firstName;
  String lastName;
  String email;
  String empId;

  Staff({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.empId,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json["id"] ?? 0,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      email: json["email"] ?? "",
      empId: json["emp_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "emp_id": empId,
      };
}
