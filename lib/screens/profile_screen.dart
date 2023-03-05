import 'dart:convert';
import 'package:loco/screens/pay_screen.dart';
import 'package:loco/screens/permission_screen.dart';
import 'package:loco/screens/profile_data_screen.dart';
import 'package:loco/screens/signIn_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../component/app_styles.dart';
import '../models/profileDataModel.dart';
import 'Language_screen.dart';
import 'about_app_screen.dart';
import 'contact_us_screen.dart';
import 'login_api.dart';
import 'map_screen.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userData = GetStorage();

  Future<ProfileDataModel?> accountDetail() async {
    var response = await http.post(
      Uri.parse(
          'http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('data==${data}');
      print('name==${data['name']}');
      return ProfileDataModel.fromJson(jsonDecode(response.body));
    } else {
      print('fail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 54.8.h, right: 20.h, left: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(NotificationScreen());
                    },
                    child:    InkWell(
                      onTap: (){
                        Get.to(NotificationScreen());
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 25.sp,
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.red,
                          //   radius: 4.r,
                          // )
                        ],
                      ),
                    ),

                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Center(
                child: SvgPicture.asset('assets/111.svg',
                    semanticsLabel: 'Acme Logo'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70.h),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Center(
                    child: userData.read('isLogged') == false
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage('${userData.read('img')}'),
                            radius: 40.r,
                          )
                        : FutureBuilder(
                            future: accountDetail(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'http://eibtekone-001-site18.atempurl.com${snapshot.data!.record!.imgUrl}'),
                                  radius: 40.r,
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                      height: 15.h,
                                      width: 15.h,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Styles.defualtColor),
                                        strokeWidth: .6.r,
                                      )),
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150.h),
              child: Center(
                child: userData.read('isLogged') == false
                    ? Text(userData.read('name'))
                    : FutureBuilder(
                        future: accountDetail(),
                        builder: (context, snapshpt) {
                          if (snapshpt.hasData) {
                            return Text(
                              '${snapshpt.data!.record!.name}',
                            );
                          } else {
                            return Center(
                              child: SizedBox(
                                  height: 15.h,
                                  width: 15.h,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Styles.defualtColor),
                                    strokeWidth: .6.r,
                                  )),
                            );
                          }
                        },
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200.h, right: 20.h, left: 20.h),
              child: Column(
                children: [
                  BuildProfileItem(
                      text: LocaleKeys.Profile_Settings.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_person_regular,
                        size: 19.sp,
                      )
                      // SvgPicture.asset(
                      //   'assets/a.svg',
                      // )
                      , onTap: () {
                    Get.to(ProfileDataScreen());
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Payment_methods_for_each_store.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_payment_regular,
                        size: 19.sp,
                      ), onTap: () {
                    Get.to(PayScreen());
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Join_Us.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_handshake_regular,
                        size: 19.sp,
                      ),
                      onTap: () {}),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Language_.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_local_language_regular,
                        size: 19.sp,
                      ), onTap: () {
                    Get.to(LanguageScreen());
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30)),
                    //       child: Container(
                    //         height: 150,
                    //         width: 100,
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text(
                    //               'يرجي إختيار اللغة',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.w600,
                    //                 fontSize: 17.sp,
                    //               ),
                    //             ),
                    //             Gap(20.h),
                    //             Padding(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 40.h),
                    //               child: Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   InkWell(
                    //                     onTap: () {},
                    //                     child: Column(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         children: [
                    //                           CircleAvatar(
                    //                               backgroundColor:
                    //                                   Colors.white,
                    //                               radius: 25.r,
                    //                               child: Container(
                    //                                 decoration:
                    //                                     BoxDecoration(
                    //                                         color: Colors
                    //                                             .grey
                    //                                             .shade800,
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(50
                    //                                                     .r),
                    //                                         image:
                    //                                             DecorationImage(
                    //                                           colorFilter:
                    //                                               ColorFilter
                    //                                                   .srgbToLinearGamma(),
                    //                                           opacity: .6,
                    //                                           image:
                    //                                               AssetImage(
                    //                                             'assets/eng.png',
                    //                                           ),
                    //                                           fit: BoxFit
                    //                                               .cover,
                    //                                         )),
                    //                               )),
                    //                           Gap(5.h),
                    //                           Text('اللغة الإنجليزية'),
                    //                         ]),
                    //                   ),
                    //                   InkWell(
                    //                     onTap: () {},
                    //                     child: Column(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         children: [
                    //                           CircleAvatar(
                    //                             backgroundColor:
                    //                                 Colors.white,
                    //                             radius: 25.r,
                    //                             child: Image(
                    //                                 image: AssetImage(
                    //                                     'assets/ara.png'),
                    //                                 fit: BoxFit.cover),
                    //                           ),
                    //                           Gap(5.h),
                    //                           Text('اللغة العربية'),
                    //                         ]),
                    //                   ),
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Contact_Us.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_phone_regular,
                        size: 19.sp,
                      ), onTap: () {
                    Get.to(ContactUsScreen());
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Country.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_location_regular,
                        size: 19.sp,
                      ), onTap: () {
                    Get.to(MapScreen());
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Share_the_app.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_share_regular,
                        size: 19.sp,
                      ),
                      onTap: () {
                        //TODO LINK GOOGLE
                        _launchUrl('https://play.google.com/store/apps/details?id=on.sam.locoapp');


                      }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.About_the_app.tr(),
                      Icon(
                        Icons.question_mark_sharp,
                        size: 19.sp,
                      ), onTap: () {
                    Get.to(AboutAppScreen());
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Terms_and_Conditions.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_notepad_regular,
                        size: 19.sp,
                      ), onTap: () {
                    Get.to(PermissionScreen());
                  }),
                  Gap(15.h),
                  BuildProfileItem(
                      text: LocaleKeys.Log_out.tr(),
                      Icon(
                        FluentSystemIcons.ic_fluent_lock_regular,
                        size: 19.sp,
                        color: Styles.defualtColor,
                      ), onTap: () {
                    userData.write('isLogged', false);
                    userData.write('isLoggedByGoogle', false);
                    userData.remove('name');
                    userData.remove('img');
                    userData.remove('email');
                    userData.remove('email');
                    userData.remove('password');
                    LoginApi.signOut();
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(LocaleKeys.Log_out.tr()),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    LocaleKeys.Are_you_sure_to_leave.tr(),
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Get.offAll(() => SignInScreen()),
                                    child: Text(
                                      LocaleKeys.Ok.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      LocaleKeys.Cancel.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            ));
                  }, color: Styles.defualtColor, color1: Styles.defualtColor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}

Widget BuildProfileItem(
  Widget? imag, {
  required String text,
  required Function() onTap,
  Color color: Colors.black,
  Color color1: Colors.black,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            imag!,
            Gap(15.h),
            Text(
              text,
              style: TextStyle(fontSize: 15.sp, color: color),
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios_outlined,
          size: 15.sp,
          color: color1,
        )
      ],
    ),
  );

}
//Center(
//                         child: SizedBox(
//                             height: 15.h,
//                             width: 15.h,
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                   Styles.defualtColor),
//                               strokeWidth: .6.r,
//                             )),
//                       );
