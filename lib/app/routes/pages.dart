import 'package:get/get.dart';
import 'package:nable_ess/app/modules/addUser/addUserBinding.dart';
import 'package:nable_ess/app/modules/addUser/addUserviews.dart';
import 'package:nable_ess/app/modules/management/base/managementBase.dart';
import 'package:nable_ess/app/modules/management/home/bindings.dart';
import 'package:nable_ess/app/modules/management/profile/bindings.dart';
import 'package:nable_ess/app/modules/management/profile/profile.dart';
import 'package:nable_ess/app/modules/management/usersDetails/binding.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/base/base.dart';
import 'package:nable_ess/app/modules/manager/managerLateEarly/base/base.dart';
import 'package:nable_ess/app/modules/manager/managerLateEarly/base/binding.dart';
// import 'package:nable_ess/app/modules/manager/managerLateEarly/binding.dart';
import 'package:nable_ess/app/modules/manager/profile/checkList.dart';
import 'package:nable_ess/app/modules/manager/profile/edit_profile.dart';
import 'package:nable_ess/app/modules/manager/videos/binding.dart';
import 'package:nable_ess/app/modules/manager/videos/staffUserProfileViews/view.dart';
import 'package:nable_ess/app/modules/staff/base/view.dart';
import 'package:nable_ess/app/modules/staff/home/binding.dart';
import 'package:nable_ess/app/modules/staff/profile/binding.dart';
import 'package:nable_ess/app/modules/staff/videos/binding.dart';
import 'package:nable_ess/app/modules/staff/videos/upload.dart';
import 'package:nable_ess/app/modules/staff/videos/view.dart';
import 'package:nable_ess/app/routes/route.dart';

import '../modules/authentication/binding.dart';
import '../modules/authentication/widgets/view/forgot_password_view.dart';
import '../modules/authentication/widgets/view/otp_verification.dart';
import '../modules/authentication/widgets/view/register_view.dart';
import '../modules/authentication/widgets/view/view.dart';
import '../modules/management/base/binding.dart';
import '../modules/management/home/form.dart';
import '../modules/management/home/view.dart';
import '../modules/management/usersDetails/UserProfileViews/view.dart';
import '../modules/management/usersDetails/view.dart';
import '../modules/management/videos/playIndividualVideos.dart';
import '../modules/manager/base/managerBase.dart';
import '../modules/manager/home/binding.dart';

import '../modules/manager/home/manager_form.dart';
import '../modules/manager/home/uploadTask/upload.dart';
import '../modules/manager/manageLeave/binding.dart';
import '../modules/manager/profile/binding.dart';
import '../modules/manager/profile/profileManager.dart';

import '../modules/manager/videos/staffUserProfileViews/playVideos.dart';
import '../modules/manager/videos/view.dart';
import '../modules/splash/binding.dart';
import '../modules/splash/view.dart';
import '../modules/staff/base/binding.dart';
import '../modules/staff/home/view.dart';
import '../modules/staff/profile/view.dart';
import '../modules/staff/profile/widgets/views/leave_history.dart';
import '../modules/staff/videos/widgets/view/play_video_staff.dart';

class GetPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.registorScreen,
      page: () => RegistorScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.managementBaseScreen,
      page: () => ManagementBase(),
      binding: ManagementBinding(),
    ),
    GetPage(
      name: AppRoutes.addUser,
      page: () => AddUser(),
      binding: AdduserBinding(),
    ),

    // Reset Password Navigation
    GetPage(
      name: AppRoutes.emailRequest,
      page: () => ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVarification,
      page: () => otpVerification(),
      binding: AuthBinding(),
    ),

    // Management
    GetPage(
        name: AppRoutes.homeManagement,
        page: () => HomeManagement(),
        binding: HomeManagementBinding(),
        transition: Transition.leftToRight),
    GetPage(
      name: AppRoutes.createUser,
      page: () => CustomTextFormField(),
      binding: HomeManagementBinding(),
    ),
    GetPage(
      name: AppRoutes.profileManagement,
      page: () => ProfileManagement(),
      binding: ProfileManagementBinding(),
    ),
    GetPage(
      name: AppRoutes.userDetailsScreen,
      page: () => UsersScreen(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.userProfileVideos,
      page: () => UserProfileVideos(),
      binding: UserDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.playIndividualVideo,
      page: () => PlayIndividualVideos(),
      binding: UserDetailsBinding(),
    ),

    // Manager
    GetPage(
      name: AppRoutes.homeManager,
      page: () => ManagerBase(),
      binding: HomeManagerBinding(),
    ),
    GetPage(
      name: AppRoutes.staffListRoute,
      page: () => StaffList(),
      binding: StaffControllerBinding(),
    ),
    GetPage(
      name: AppRoutes.profileManager,
      page: () => ProfileManager(),
      binding: ProfileManagerBinding(),
    ),

    GetPage(
      name: AppRoutes.editProfileManager,
      page: () => EditProfileManager(),
    ),
    GetPage(
      name: AppRoutes.checkListScreen,
      page: () => CheckList(),
    ),
    GetPage(
      name: AppRoutes.managerForm,
      page: () => ManagerForm(),
      binding: HomeManagerBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.staffProfileVideos,
      page: () => StaffProfileVideos(),
      binding: StaffControllerBinding(),
    ),
    GetPage(
      name: AppRoutes.playVideos,
      page: () => PlayVideosStaff(),
      binding: StaffControllerBinding(),
      transition: Transition.leftToRight,
    ),
    //manager Leave module
    GetPage(
      name: AppRoutes.leaveBase,
      page: () => LeaveBaseView(),
      binding: LeaveBindings(),
    ),
    // GetPage(
    //   name:AppRoutes.leaveBase,
    //   page: ()=> LeaveForm(),
    //   binding: LeaveBindings(),
    // ),
    // GetPage(
    //   name: AppRoutes.leaveBase,
    //   page: () => History(),
    //   binding: LeaveBindings(),
    // ),
    // GetPage(
    //   name: AppRoutes.leaveBase,
    //   page: () => LeaveNotification(),
    //   binding: LeaveBindings(),
    // ),

    //Upload Task
    GetPage(
      name: AppRoutes.uploadTask,
      page: () => UploadTask(),
      binding: StaffControllerBinding(),
      transition: Transition.leftToRight,
    ),


   GetPage(
        name: AppRoutes.lateEarlyBase,
        page: () => LateEarlybaseView(),
        // binding: LateEarlyNotificationBinding(),
      ),
    // Staff
    GetPage(
      name: AppRoutes.staffBase,
      page: () => StaffBase(),
      binding: StaffBinding(),
    ),
    GetPage(
      name: AppRoutes.homeStaff,
      page: () => HomeStaff(),
      binding: StaffHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.profileStaff,
      page: () => StaffProfile(),
      binding: StaffProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCardPromo,
      page: () => VideoCardPromo(),
      binding: VideoControllerBinding(),
    ),
    GetPage(
      name: AppRoutes.uploadVideoScreen,
      page: () => UploadVideoScreen(),
      binding: VideoControllerBinding(),
    ),
    GetPage(
      name: AppRoutes.staffVideoPlay,
      page: () => StaffVideoPlay(),
      binding: VideoControllerBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveHistoryStaff,
      page: () => StaffLeaveHistory(),
      binding: StaffProfileBinding(),
    ),
  ];
}
