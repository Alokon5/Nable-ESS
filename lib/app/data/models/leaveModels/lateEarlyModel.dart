import 'dart:convert';  // For JSON decoding

class LateEarlyModel {
  int id;
  String lateEarly;
  DateTime date;
  String time;
  String reason;
  bool seen;
  String status;
  String? attachment;  // Nullable, can be null if not present in the response
  DateTime createdAt;
  UserDetail? user;  // Optional user field (nullable)

  LateEarlyModel({
    required this.id,
    required this.lateEarly,
    required this.date,
    required this.time,
    required this.reason,
    required this.seen,
    required this.status,
    this.attachment,
    required this.createdAt,
    this.user,  // Optional parameter
  });

  // Factory constructor to create an instance of LateEarlyModel from JSON
  factory LateEarlyModel.fromJson(Map<String, dynamic> json) {
    return LateEarlyModel(
      id: json['id'],
      lateEarly: json['late_early'],
      date: DateTime.parse(json['date']),  // Assuming date is in string format, adjust if needed
      time: json['time'],
      reason: json['reason'],
      seen: json['seen'],
      status: json['status'],
      attachment: json['attachment'],  // Can be null or a different type
      createdAt: DateTime.parse(json['created_at']),  // Adjust as needed
      user: json['user'] != null ? UserDetail.fromJson(json['user']) : null,  // Ensure 'user' is parsed correctly if exists
    );
  }

  // Method to convert LateEarlyModel to JSON (if needed for sending data back to server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'late_early': lateEarly,
      'date': date.toIso8601String(),  // Convert DateTime to ISO string
      'time': time,
      'reason': reason,
      'seen': seen,
      'status': status,
      'attachment': attachment,
      'created_at': createdAt.toIso8601String(),  // Convert DateTime to ISO string
      'user': user?.toJson(),  // Ensure 'user' is serialized properly if it exists
    };
  }
}

// Updated UserDetail class (previously User)

class UserDetail {
  int id;
  String email;
  String firstName;
  String lastName;
  String? dob;
  String? dateJoined;
  String? phoneNumber;
  String? phoneNumber2;
  String? fatherHusbandName;
  String? fatherHusbandMobile;
  String? joiningDate;
  String? address;
  String? homeAddress;
  String? gender;
  String? bloodGroup;
  String? maritalStatus;
  String? status;
  String? profileImage;
  String? userType;
  bool isStaff;
  bool isActive;
  bool isSuperuser;

  UserDetail({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dob,
    this.dateJoined,
    this.phoneNumber,
    this.phoneNumber2,
    this.fatherHusbandName,
    this.fatherHusbandMobile,
    this.joiningDate,
    this.address,
    this.homeAddress,
    this.gender,
    this.bloodGroup,
    this.maritalStatus,
    this.status,
    this.profileImage,
    this.userType,
    required this.isStaff,
    required this.isActive,
    required this.isSuperuser,
  });

  // Factory method to parse JSON into the UserDetail object
  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dob: json['dob'],
      dateJoined: json['date_joined'],
      phoneNumber: json['phone_number'],
      phoneNumber2: json['phone_number2'],
      fatherHusbandName: json['father_husband_name'],
      fatherHusbandMobile: json['father_husband_mobile'],
      joiningDate: json['joining_date'],
      address: json['address'],
      homeAddress: json['home_address'],
      gender: json['gender'],
      bloodGroup: json['blood_group'],
      maritalStatus: json['marital_status'],
      status: json['status'],
      profileImage: json['profile_image'],
      userType: json['user_type'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
      isSuperuser: json['is_superuser'],
    );
  }

  // Method to convert the UserDetail object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'date_joined': dateJoined,
      'phone_number': phoneNumber,
      'phone_number2': phoneNumber2,
      'father_husband_name': fatherHusbandName,
      'father_husband_mobile': fatherHusbandMobile,
      'joining_date': joiningDate,
      'address': address,
      'home_address': homeAddress,
      'gender': gender,
      'blood_group': bloodGroup,
      'marital_status': maritalStatus,
      'status': status,
      'profile_image': profileImage,
      'user_type': userType,
      'is_staff': isStaff,
      'is_active': isActive,
      'is_superuser': isSuperuser,
    };
  }
}
