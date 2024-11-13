// ignore_for_file: unnecessary_null_comparison, body_might_complete_normally_nullable

import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:nable_ess/app/data/models/allEmployeesModel.dart';
import 'package:nable_ess/app/data/models/allVideosModel/allVideoModel.dart';
import 'package:nable_ess/app/data/models/designationModel/designationModel.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveListModel.dart';
import 'package:nable_ess/app/data/models/login_model.dart';
import 'package:nable_ess/app/data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import 'package:nable_ess/app/data/models/staffList.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';
import 'package:nable_ess/app/data/models/user_model.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';

import '../models/allUserDocList.dart';
import '../models/createManagerModel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class APIsProvider extends GetConnect {
  // static const apiBaseUrl = "http://192.168.1.248:9000/";
  // static const mediaBaseUrl = "http://192.168.1.248:9000";
  static const apiBaseUrl = "https://ess.nablean.com/";
  static const mediaBaseUrl = "https://ess.nablean.com";
  //My local system api
  // static const apiBaseUrl = "http://192.168.1.3:8000/";
  // static const mediaBaseUrl = "http://192.168.1.3:8000";
  // static const apiBaseUrl = "http://192.168.1.69:8000/";
  // static const mediaBaseUrl = "http://192.168.1.69:8000";

  var createUser = StorageProvider();

  // user accout
  static const updateLeaveRequest = "${apiBaseUrl}api/show_leave/";
  static const logOut = "${apiBaseUrl}api/user/logout";
  static const getRequestedLeaves = "${apiBaseUrl}api/leaves_mageners_staff";
  static const allRequestedLeave = "${apiBaseUrl}api/all_leave_request";
  static const getDesignation = "${apiBaseUrl}api/designation";
  static const allVideos = "${apiBaseUrl}api/all_taskupload";
  static const getStaffViaManagerId = "${apiBaseUrl}api/managers_staff/";
  static const getleaveList = "${apiBaseUrl}api/show_leavelist_employee";
  static const leaveType = "${apiBaseUrl}api/leave_type";
  static const applyForleave = "${apiBaseUrl}api/leave";
  static const loginMangementUrl = "${apiBaseUrl}api/user/login";

  // Reset Password Apis
  static const resetEmailRequest = "${apiBaseUrl}reset_request";
  static const otpCheck = "${apiBaseUrl}check_otp";
  static const resetPassword = "${apiBaseUrl}reset_password";

  static const createUserUrl = "${apiBaseUrl}api/createuser";
  static const getMangersList = "${apiBaseUrl}api/get_managers";
  static const getAllStaffs = "${apiBaseUrl}api/get_staffs";
  static const getStaffs = "${apiBaseUrl}api/getstaffs";
  static const checkIn = "${apiBaseUrl}api/check_in";
  static const checkOut = "${apiBaseUrl}api/check_out";
  static const taskUpload = "${apiBaseUrl}api/taskupload";
  static const allUsers = "${apiBaseUrl}api/getstaffs";
  static const createStaffUrl = "${apiBaseUrl}api/createuser";
  static const updateUserProfileUrl = "${apiBaseUrl}api/updateuser/";
  static const fetchUserUrl = "${apiBaseUrl}api/user/";
  static const all_employees = "${apiBaseUrl}api/all_employees";
  static const employees_detail = "${apiBaseUrl}api/employees_detail/";
  //Documents api
  static const uploadDoc = "${apiBaseUrl}api/upload_document";
  static const updateDoc = "${apiBaseUrl}api/update_document/";
  static const deleteDoc = "${apiBaseUrl}api/delete_document/";
  static const getDocListApi = "${apiBaseUrl}api/all_documets";
  //Late Early post
  static const lateEarlyPost = "${apiBaseUrl}api/lateEarlyReason";
  static const getLateEarly = "${apiBaseUrl}api/getAllLateEarly";

  // Future<LateEary> getAllLateEarlyList(token) async {
  //   try {
  //     var header = {"Authorization": "token $token"};
  //     final response = await get(getLateEarly, headers: header);
  //     if (response.statusCode == 201) {}
  //   } catch (e) {}
  // }

  Future<bool> postLateEarlyData(token, drop, date, time, reason) async {
    print("under water");
    print(reason);
    printInfo(
        info: "values:::::::$date,time:::::::::::$time,reason-------$reason");
    try {
      var body = {
        'late_early': '$drop',
        'date': '$date',
        'time': '$time',
        'reason': '$reason',
        
      };
      final res = await post(
          lateEarlyPost, headers: {"Authorization": "token $token"}, body);
      if (res.statusCode == 201) {
        EasyLoading.showSuccess("You have successful applied!");
        return true;
      } else {
        EasyLoading.showSuccess("Faild !");
        return false;
      }
    } catch (e) {
      EasyLoading.showSuccess("Timed out $e !");
      return false;
    }
  }

  Future<List<AllDocList>> getDocList(String? token) async {
    try {
      final res =
          await get(getDocListApi, headers: {'Authorization': 'token $token'});
      // printInfo(info: "response of get documents----${res.body}");
      List<dynamic> responseList = res.body;
      List<AllDocList> listOfDoc = List<AllDocList>.from(
        responseList.map((item) => AllDocList.fromJson(item)),
      );
      printInfo(info: "docu length==========${listOfDoc.length}");

      return listOfDoc;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> deleteDocuments(String? token, int docId) async {
    try {
      String url = "${deleteDoc}${docId}";
      printInfo(info: 'docPath=====${token},url--${url},docId--$docId');
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          // Add any required headers here
          'Authorization': 'token $token',
        },
      );
      printInfo(
          info: 'response of delete document --=-==-=-${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("You have successful deleted document !");

        return true;
      } else {
        EasyLoading.showSuccess("Faild to delete document !");
        return false;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      printInfo(info: "erorr======$e");
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<bool> updateDocuments(
      String? token, pdfPath, docName, int docId) async {
    try {
      String url = "${updateDoc}${docId}";
      printInfo(
          info: 'docPath=====${pdfPath},url--${uploadDoc},docName--$docName');
      final request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers['Authorization'] = 'token $token';
      request.files.add(
        await http.MultipartFile.fromPath('document', pdfPath.toString()),
      );
      request.fields['document_name'] = "${docName.toString()}";
      final response = await request.send();
      printInfo(
          info:
              'response of updated document is equal to --=-==-=-${response.statusCode}');

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("You have successful updated document !");

        return true;
      } else {
        EasyLoading.showSuccess("Faild to update document !");
        return false;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      printInfo(info: "erorr======$e");
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<bool> uploadDocuments(String? token, pdfPath, docName, id) async {
    try {
      printInfo(
          info: 'docPath=====${pdfPath},url--${uploadDoc},docName--$docName');
      final request = http.MultipartRequest('POST', Uri.parse(uploadDoc));

      request.headers['Authorization'] = 'token $token';
      request.files.add(
        await http.MultipartFile.fromPath('document', pdfPath.toString()),
      );
      request.fields['user'] = "${id.toString()}";
      request.fields['document_name'] = "${docName.toString()}";
      final response = await request.send();
      printInfo(
          info: 'response of upload document --=-==-=-${response.statusCode}');

      if (response.statusCode == 201) {
        EasyLoading.showSuccess("You have successful uploaded document !");

        return true;
      } else {
        EasyLoading.showSuccess("Faild to uploaded document !");
        return false;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      printInfo(info: "erorr======$e");
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<bool?> checkInHit(String? token) async {
    GetStorage storage = GetStorage();

    try {
      var body = {
        "check_in": "Checked in",
      };
      var res =
          await post(checkIn, headers: {"Authorization": "token $token"}, body);

      if (res.statusCode == 201) {
        await storage.write("checkIn", true);
        EasyLoading.showSuccess("You have successful Checked In , thank you !");

        return true;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<bool?> logoutApi(String? token) async {
    try {
      var res = await post(
          logOut, headers: {"Authorization": "token $token"}, {"key": token});
      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        // EasyLoading.showSuccess("You have successful log out !");

        return true;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<List<DesignationModel>?> getDesignationList(token) async {
    try {
      final res =
          await get(getDesignation, headers: {'Authorization': 'token $token'});
      print("designation --=-=-=-${res.body}");
      List<dynamic> responseList = res.body;
      List<DesignationModel> listOfLeave = List<DesignationModel>.from(
        responseList.map((item) => DesignationModel.fromJson(item)),
      );

      return listOfLeave;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<RequestedLeaveModel>?> getAllRequestedLeave(token) async {
    try {
      print("api hitting");
      final res = await get(allRequestedLeave,
          headers: {'Authorization': 'token $token'});
      print(res.body);
      List<dynamic> responseList = res.body;
      List<RequestedLeaveModel> listOfLeave = List<RequestedLeaveModel>.from(
        responseList.map((item) => RequestedLeaveModel.fromJson(item)),
      );

      return listOfLeave;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<RequestedLeaveModel>?> getRequestedLeave(token) async {
    try {
      print("api hitting");
      final res = await get(getRequestedLeaves,
          headers: {'Authorization': 'token $token'});
      print(res.body);
      List<dynamic> responseList = res.body;
      List<RequestedLeaveModel> listOfLeave = List<RequestedLeaveModel>.from(
        responseList.map((item) => RequestedLeaveModel.fromJson(item)),
      );

      return listOfLeave;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> requestApprovelApi(token, id) async {
    print(id);
    print("this is calling now ");
    try {
      final res = await put(
          updateLeaveRequest + id.toString(),
          headers: {'Authorization': 'token $token'},
          {"status": "Approved"});
      print("response.statusCode -----${res.statusCode}");
      print("response.body -----${res.body}");

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> seenApi(token, id) async {
    print(id);

    try {
      final res = await get(updateLeaveRequest + id.toString(),
          headers: {'Authorization': 'token $token'});
      print("response.statusCode -----${res.statusCode}");
      print("response.body -----${res.body}");

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> requestDeclineApi(token, id) async {
    try {
      final res = await put(
          updateLeaveRequest + id.toString(),
          headers: {'Authorization': 'token $token'},
          {"status": "Declined"});
      print("this is calling now decline");
      print("response.statusCode -----${res.statusCode}");
      print("response.body -----${res.body}");
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<LeaveListModel>?> getLeaveList(token) async {
    try {
      final res =
          await get(getleaveList, headers: {'Authorization': 'token $token'});
      print("response of get leave----${res.body}");
      List<dynamic> responseList = res.body;
      List<LeaveListModel> listOfLeave = List<LeaveListModel>.from(
        responseList.map((item) => LeaveListModel.fromJson(item)),
      );

      return listOfLeave;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List> getLeaveTypeList(token) async {
    try {
      final res =
          await get(leaveType, headers: {'Authorization': 'token $token'});

      return res.body;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> applyLeave(token, leaveTitle, leaveDescription, dateFrom, dateTo,
      selecteLeaveType) async {
    try {
      var uri = Uri.parse(applyForleave);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'token $token';
      request.fields['title'] = leaveTitle;
      request.fields['description'] = leaveDescription;
      request.fields['from_date'] = dateFrom;
      request.fields['to_date'] = dateTo;
      request.fields['leave_type'] = selecteLeaveType.toString();
      // image != null
      //     ? request.files.add(
      //         await http.MultipartFile.fromPath(
      //           'profile_image',
      //           image,
      //           contentType: MediaType('profile_image', 'png'),
      //         ),
      //       )
      //     : request.fields['profile_image'];

      var response = await request.send();
      var res = await response.stream.bytesToString();
      print("responser ----${response.statusCode}");
      print("responser res ----${res}");

      if (response.statusCode == 200) {
        // Request successful

        return true;
      } else {
        // Request failed
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editProfile(image, id, String? token, firstName, lastName,
      gender, phoneNumber, address) async {
    print(
        "image--${image},firstName----${firstName},lastName----${lastName},gender----${gender},phoneNumber-0--${phoneNumber},address--${address}");
    print("updateUserProfileUrl---${updateUserProfileUrl}");
    print("id---${id}");
    try {
      var uri = Uri.parse(updateUserProfileUrl + id.toString());
      var request = http.MultipartRequest('PUT', uri);
      request.headers['Authorization'] = 'token ${token}';
      request.fields['address'] = address;
      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['phone_number'] = phoneNumber;
      request.fields['gender'] = gender.toString();
      image != null
          ? request.files.add(
              await http.MultipartFile.fromPath(
                'profile_image',
                image,
                contentType: MediaType('profile_image', 'png'),
              ),
            )
          : request.fields['profile_image'];

      var response = await request.send();
      var res = await response.stream.bytesToString();
      print("responser ----${response.statusCode}");
      print("responser res ----${res}");

      if (response.statusCode == 201) {
        // Request successful
        var userDetails = await getuserDetailWirteStorage(token, id);
        final GetStorage storage = GetStorage();
        await storage.erase();
        UserModel createDeviceUser = UserModel(
          email: userDetails.user!.email,
          role: userDetails.user!.userType,
          token: token,
          displayName: "${userDetails.user!.firstName} "
              " ${userDetails.user!.lastName}",
          firstName: userDetails.user!.firstName,
          lastName: userDetails.user!.lastName,
          photoUrl: userDetails.user!.profileImage,
          designation: userDetails.user!.designation.toString(),
          joinedDate: userDetails.user!.joinedDate,
          id: id,
          lati: "22.070",
          longi: "82.143",
        );
        await createUser.writeUserModel(createDeviceUser);

        print('Profile updated successfully');
        Get.back();
        return true;
      } else {
        // Request failed
        print('Profile update failed');
        return false;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<UserDetailsModel> getuserDetailWirteStorage(String? token, id) async {
    print(token);
    print(id);

    try {
      var res = await get(employees_detail + id.toString(),
          headers: {"Authorization": "token $token"});

      print("response UserDetails and there videos: ${res.body}");
      if (res.statusCode == 200) {
        UserDetailsModel listOfStaffs = UserDetailsModel.fromJson(res.body);
        return listOfStaffs;
      } else if (res.statusCode == 400) {
        var message = json.decode(res.body)["email"];
        EasyLoading.showError(
            message.toString() ?? "Failed to fetch user details");
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }

    return UserDetailsModel(video: []);
  }

  Future<bool?> checkOutHitp(String? token) async {
    GetStorage storage = GetStorage();

    try {
      var body = {
        "check_out": "Checked Out",
      };
      var res = await post(
          checkOut, headers: {"Authorization": "token $token"}, body);

      if (res.statusCode == 201) {
        await storage.write("checkIn", false);
        EasyLoading.showSuccess(
            "You have successful Checked Out , thank you !");

        return true;
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
  }

  Future<bool> loginAsManagement(String email, String password) async {
    try {
      var res =
          await post(loginMangementUrl, {"email": email, "password": password});
      print("response.status code -=-=--=-=-=-${res.body}");
      if (res.statusCode == 202) {
        await GetStorage().write("checkIn", null);
        LoginModel deviceUser = LoginModel.fromJson(res.body);

        UserModel createDeviceUser = UserModel(
          email: deviceUser.data!.email,
          role: deviceUser.data!.userType,
          token: deviceUser.token,
          displayName: "${deviceUser.data!.firstName} "
              " ${deviceUser.data!.lastName}",
          firstName: deviceUser.data!.firstName,
          lastName: deviceUser.data!.lastName,
          photoUrl: deviceUser.data!.profileImage,
          id: deviceUser.data!.id,
          lati: "22.070",
          longi: "82.143",
        );
        await createUser.writeUserModel(createDeviceUser);

        EasyLoading.showSuccess(
          "login Successful",
        );
        return true;
      } else if (res.statusCode == 400) {
        var message = res.body["message"];
        EasyLoading.showError(message ?? "login Failed");
        return false;
      } else if (res.statusCode == null) {
        EasyLoading.showError("Server not found !");
      }
    } catch (e) {
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
    }

    return false;
  }

  Future<bool?> forgotEmailRequest(String email) async {
    try {
      var res = await post(
        resetEmailRequest,
        {"email": email},
      );
      print("response.status code -=-=--=-=-=-${res.body}");
      if (res.statusCode == 200) {
        EasyLoading.showSuccess(
          "Send OTP Successful",
        );
        return true;
      }
    } catch (e) {
      EasyLoading.showError(
        e.toString(),
      );
      return false;
    }
  }

  Future<bool?> forgotOtpVerification(String email, String otp) async {
    try {
      var res = await post(
        otpCheck,
        {"email": email, "otp": otp},
      );
      print("response.status code -=-=--=-=-=-${res.body}");
      if (res.statusCode == 200) {
        EasyLoading.showSuccess(
          "OTP Varified",
        );
        return true;
      } else {
        EasyLoading.showSuccess(
          "OTP Not Varified",
        );
      }
    } catch (e) {
      EasyLoading.showError(
        e.toString(),
      );

      return false;
    }
  }

  Future<bool> forgotConfirmPassword(String email, String password) async {
    try {
      var res =
          await put(resetPassword, {"email": email, "password": password});
      print("response.status code -=-=--=-=-=-${res.body}");
      if (res.statusCode == 200) {
        EasyLoading.showSuccess(
          "Password Change Successful",
        );
        return true;
      }
    } catch (e) {
      EasyLoading.showError(
        e.toString(),
      );
      return false;
    }
    return false;
  }

  Future<bool> createNewManager(
      String? email,
      password,
      firstName,
      lastName,
      gender,
      dateOfBirth,
      selectedRole,
      selectedDepartments,
      int destignation,
      address,
      phoneNumber) async {
    print("hit hua destignationId ----$destignation");
    print(selectedRole);
    CreateUser createUserManager = CreateUser(
        password: password,
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
        phoneNumber: phoneNumber,
        gender: gender.toString(),
        designation: destignation.toString(),
        userType: "Manager");

    String jsonCreateUser = createUserToJson(createUserManager);

    try {
      var res = await post(createUserUrl, jsonCreateUser);
      print("res.body--------${res.body}");
      if (res.statusCode == 201) {
        EasyLoading.showSuccess(
          "Created User Successful",
        );
        Get.back();
        return true;
      } else if (res.body["email"] != null) {
        var message = res.body["email"];
        print("message-------$message");

        EasyLoading.showError(
            message.toString() ?? " Failed to create new user");

        return false;
      } else {
        EasyLoading.showError(
            res.body["password"].toString() ?? " Failed to create new user");
        return false;
      }
    } catch (e) {
      print("e-=--=--=-=-=-$e");
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
      return false;
    }

    // return false;
  }

  Future<bool> createNewStaff(
      String? email,
      password,
      firstName,
      lastName,
      address,
      phoneNumber,
      gender,
      selectedRole,
      managerId,
      designation) async {
    print("manager Id ====$managerId");
    print(selectedRole);
    print("gender======${gender}");

    // var data = {
    //   "password": password,
    //   "first_name": firstName,
    //   "last_name": lastName,
    //   "phone_number": phoneNumber,
    //   "address": address,
    //   "email": email,
    //   "gender": gender.toString(),
    //   "user_type": selectedRole.toString(),
    //   "manager": managerId.toString(),
    //     "designation": designation.toString(),
    // };
    CreateUser createUserManager = CreateUser(
        email: email.toString(),
        password: password.toString(),
        firstName: firstName.toString(),
        lastName: lastName.toString(),
        gender: gender.toString(),
        address: address.toString(),
        phoneNumber: phoneNumber.toString(),
        designation: designation.toString(),
        userType: "Staff",
        manager: managerId.toString());

    String jsonCreateUser = createUserToJson(createUserManager);

    try {
      var res = await post(createUserUrl, jsonCreateUser);
      print("response --=----=${res.body}");

      if (res.statusCode == 201) {
        EasyLoading.showSuccess(
          "Created User Successful",
        );
        Get.back();
        return true;
      } else if (res.body["email"] != null) {
        var message = res.body["email"];
        print("message-------$message");

        EasyLoading.showError(
            message.toString() ?? " Failed to create new user");

        return false;
      } else {
        EasyLoading.showError(
            res.body["password"].toString() ?? " Failed to create new user");
        return false;
      }
    } catch (e) {
      print("e-=--=--=-=-=-$e");
      // EasyLoading.showError(
      //   e.toString(),
      // );
      EasyLoading.showError("Connection Timed out ");
      return false;
    }
    // return false;
  }

  Future<StaffListModel> fetchStaffs(String? token) async {
    print(token);

    try {
      var res =
          await get(getStaffs, headers: {"Authorization": "token $token"});
      print(res.statusCode);

      print("responseStaffList: ${res.body}");
      if (res.statusCode == 200) {
        StaffListModel listOfStaffs = StaffListModel.fromJson(res.body);
        return listOfStaffs;
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError(e.toString());
    }

    return StaffListModel(staffs: []);
  }

  Future<AllEmployeesModel?> fetchAllEmployees(String? token) async {
    print(token);

    try {
      var res =
          await get(all_employees, headers: {"Authorization": "token $token"});

      // print("users-sdfsfga g agsgsgsdgfd--${res.body}");
      if (res.statusCode == 200) {
        AllEmployeesModel listOfStaffs = AllEmployeesModel.fromJson(res.body);
        return listOfStaffs;
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError(e.toString());
      return AllEmployeesModel(data: []);
    }
  }

  Future<AllEmployeesModel> fetchAllStaffForManageMent(String? token) async {
    print(token);

    try {
      var res =
          await get(getAllStaffs, headers: {"Authorization": "token $token"});

      if (res.statusCode == 200) {
        AllEmployeesModel listOfStaffs = AllEmployeesModel.fromJson(res.body);
        return listOfStaffs;
      } else if (res.statusCode == 400) {
        var message = json.decode(res.body)["email"];

        EasyLoading.showError(message.toString() ?? "Failed to fetch users");
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError(e.toString());
    }

    return AllEmployeesModel(data: []);
  }

  Future<AllEmployeesModel> fetchStaffsViaManagerId(String? token, id) async {
    print(token);

    try {
      var res = await get(getStaffViaManagerId + id.toString(),
          headers: {"Authorization": "token $token"});
      print("response --${res.body}");

      if (res.statusCode == 200) {
        AllEmployeesModel listOfStaffs = AllEmployeesModel.fromJson(res.body);
        return listOfStaffs;
      } else if (res.statusCode == 400) {
        var message = json.decode(res.body)["email"];

        EasyLoading.showError(message.toString() ?? "Failed to fetch users");
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError(e.toString());
    }

    return AllEmployeesModel(data: []);
  }

  Future<AllEmployeesModel> fetchAllManagers(String? token) async {
    print(token);

    try {
      var res =
          await get(getMangersList, headers: {"Authorization": "token $token"});

      if (res.statusCode == 200) {
        AllEmployeesModel listOfStaffs = AllEmployeesModel.fromJson(res.body);
        return listOfStaffs;
      } else if (res.statusCode == 400) {
        var message = json.decode(res.body)["email"];

        EasyLoading.showError(message.toString() ?? "Failed to fetch users");
      }
    } catch (e) {
      print("Error: $e");
      EasyLoading.showError(e.toString());
    }

    return AllEmployeesModel(data: []);
  }

  Future<AllVideosModel?> fetchAllVideos(String? token) async {
    print(token);

    try {
      var res =
          await get(allVideos, headers: {"Authorization": "token $token"});

      // print("response UserDetails and there videos: ${res.body['check_in']}");
      print("response status-=-=-=-=-=-${res.body}");
      if (res.statusCode == 200) {
        AllVideosModel listOfStaffs = AllVideosModel.fromJson(res.body);
        print("userDetails.check In List -------${listOfStaffs.data!.length}");
        return listOfStaffs;
      } else if (res.statusCode == 400) {
        var message = json.decode(res.body)["email"];
        EasyLoading.showError(
            message.toString() ?? "Failed to fetch user details");
        return AllVideosModel(data: []);
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return AllVideosModel(data: []);
    }
  }

  Future<List<AllDocList>> fetchDocument(String? token, id) async {
    printInfo(
        info:
            " user id while fetching document ======${id} Token======== this is fetchDocument======${token}");
    try {
      var res = await get(employees_detail + id.toString(),
          headers: {"Authorization": "token $token"});

      // print("response UserDetails and there videos: ${res.body['check_in']}");
      // print("response body-=-=-=-=-=-${res.body['documents']}");
      // printInfo(info: "response body-=-=-=-=-=-${res.body['documents']}");
      if (res.statusCode == 200) {
        List<dynamic> responseList = res.body['documents'];
        List<AllDocList> listOfDocument = List<AllDocList>.from(
          responseList.map((item) => AllDocList.fromJson(item)),
        );
        // print("userDetails.check In List -------${listOfStaffs}");
        // printInfo(info: "checkIN Object list--==============${res.body} ,");
        printInfo(
            info: "length of listOfDoc-=-=-==========${listOfDocument.length}");
        return listOfDocument;
      } else if (res.statusCode == 400) {
        // var message = json.decode(res.body)["email"];
        EasyLoading.showError("Failed to fetch user details");
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      return [];
    }
    return [];
  }

  Future<UserDetailsModel> fetchUserDetails(String? token, id) async {
    print(token);
    print(id);

    try {
      var res = await get(employees_detail + id.toString(),
          headers: {"Authorization": "token $token"});

      // print("response UserDetails and there videos: ${res.body['check_in']}");
      // print("response body-=-=-=-=-=-${res.body['documents']}");
      printInfo(info: "response body-=-=-=-=-=-${res.body['documents']}");
      if (res.statusCode == 200) {
        UserDetailsModel listOfStaffs = UserDetailsModel.fromJson(res.body);
        // print("userDetails.check In List -------${listOfStaffs}");
        printInfo(info: "checkIN Object list--==============${res.body} ,");
        return listOfStaffs;
      } else if (res.statusCode == 400) {
        var message = json.decode(res.body)["email"];
        EasyLoading.showError(
            message.toString() ?? "Failed to fetch user details");
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }

    return UserDetailsModel(video: []);
  }

  Future<bool> uploadTask(
      imageThumb, String title, String description, videoFile, token) async {
    print("imageThumb--${imageThumb}");
    print("videoFile--${videoFile}");
    print("token--${token}");
    print("title--${title}");
    // String token = "ff50b2ac7e773a2ef64b07a4f603e31348a6b088";

    if (videoFile == null) {
      print('Video file is null.');
      Get.snackbar(
        'Upload Error',
        'Video file is missing.',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    try {
      var uri = Uri.parse(taskUpload);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'token ${token}';
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videoFile,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      imageThumb != null
          ? request.files.add(
              await http.MultipartFile.fromPath(
                'thumbnail',
                imageThumb,
                contentType: MediaType('thumbnail', 'png'),
              ),
            )
          : request.fields['profile_image'];

      var response = await request.send();
      var res = await response.stream.bytesToString();
      print("responser ----${response.statusCode}");
      print("responser ----${res}");

      if (response.statusCode == 201) {
        // Request successful

        Get.snackbar(
          'Upload Successful',
          'Video uploaded successfully.',
          snackPosition: SnackPosition.TOP,
        );
        print('Video uploaded successfully');
        return true;
      } else {
        // Request failed

        Get.snackbar(
          'Upload Error',
          'Failed to upload the video. Please try again.',
          snackPosition: SnackPosition.TOP,
        );
        print('Video upload failed');
        return false;
      }
    } catch (e) {
      // Exception occurred

      Get.snackbar(
        'Upload Error',
        'An error occurred during video upload. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      print('Exception during video upload: $e');
      return false;
    }
  }
}
