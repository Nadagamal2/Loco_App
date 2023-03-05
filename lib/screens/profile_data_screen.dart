import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';

import '../component/app_styles.dart';
import '../component/component.dart';
import '../models/profileDataModel.dart';
import 'editProfileDataSceen.dart';
import 'editProfilePasswordScreen.dart';
import 'package:http/http.dart' as http;

class ProfileDataScreen extends StatefulWidget {
  const ProfileDataScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  final userData = GetStorage();
  Future<ProfileDataModel?> accountDetail() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),
      );

      if (response.statusCode == 200) {
        print(userData.read('token'));
        var data = jsonDecode(response.body.toString());
        print(data);
        return ProfileDataModel.fromJson(jsonDecode(response.body));
      } else {
        print('fail');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 690.h,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 45.h, right: 20.h, left: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25.sp,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 90.h),
              child: Center(
                child: SvgPicture.asset('assets/111.svg',
                    semanticsLabel: 'Acme Logo'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 120.h),
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
              padding: EdgeInsets.only(top: 200.h),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.Welcome.tr(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(5.h),
                        Image(
                            //fit: BoxFit.cover,
                            height: 15.h,
                            width: 15.h,
                            image: AssetImage(
                              'assets/hand.png',
                            ))
                      ],
                    ),
                    userData.read('isLogged') == false
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
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Styles.defualtColor),
                                        strokeWidth: .6.r,
                                      )),
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 260.h, right: 20.h, left: 20.h),
              child: Center(
                child: Column(
                  children: [
                    // Container(
                    //
                    //   decoration: BoxDecoration(
                    //     color: Color(0xffF6F7FB),
                    //     borderRadius: BorderRadius.circular(15.r),
                    //   ),
                    //   height: 50.h,
                    //   padding: EdgeInsets.symmetric(horizontal: 20.h),
                    //   child: Row(
                    //     children: [
                    //       Image(image: AssetImage('assets/y.png')),
                    //       Gap(10.h),
                    //       Text('أحمد مندور')
                    //     ],
                    //   ),
                    // ),
                    Gap(10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF6F7FB),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Row(
                        children: [
                          Icon(Icons.mail_outline,color: Colors.grey.shade400,),
                          Gap(10.h),
                          userData.read('isLogged') == false
                              ? Text(userData.read('email'))
                              : FutureBuilder(
                                  future: accountDetail(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          '${snapshot.data!.record!.email}');
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
                                )
                        ],
                      ),
                    ),
                    Gap(10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF6F7FB),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      height: 50.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Row(
                        children: [
                          Icon(Icons.phone,color: Colors.grey.shade400,),
                          Gap(10.h),
                          userData.read('isLogged') == false
                              ? Text( '')
                              : FutureBuilder(
                            future: accountDetail(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    '${snapshot.data!.record!.phone}');
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
                          )
                        ],
                      ),
                    ),
                    Gap(10.h),

                    Gap(25.h),
                    buildBottum(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: double.infinity,
                      text: Text(
                        LocaleKeys.Modify_your_Account.tr(),
                        style: TextStyle(
                            color: Styles.defaultColor5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        userData.read('isLogged') == false? Fluttertoast.showToast(
                            msg: 'Can\'t Modify Google Account' ,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Styles.defualtColor,


                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0
                        ):
                        Get.to(EditProfileScreen());
                      },
                    ),

                    Gap(25.h),
                    buildBottum(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: double.infinity,
                      text: Text(
                        LocaleKeys.Change_Password.tr(),
                        style: TextStyle(
                            color: Styles.defaultColor5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        userData.read('isLogged') == false? Fluttertoast.showToast(
                            msg: 'Can\'t Change Password of Google Account' ,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Styles.defualtColor,


                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0
                        ):
                        Get.to(EditPasswordScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
