import 'dart:convert';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:http/http.dart' as http;

import '../component/app_styles.dart';
import '../models/profileDataModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final userData = GetStorage();
  Future<ProfileDataModel?> accountDetail() async {
    var response = await http.post(
      Uri.parse('http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      var data=jsonDecode(response.body.toString());
      print(data);
      return ProfileDataModel .fromJson(data);


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
              height: 150.h,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [



                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.h, right: 20.h, left: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          userData.read('isLogged')==false?
                          CircleAvatar(
                            backgroundImage:  NetworkImage('${userData.read('img')}'),
                            radius: 25.r,
                          ):FutureBuilder(
                            future: accountDetail(),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return CircleAvatar(
                                  backgroundImage:  NetworkImage('http://eibtekone-001-site18.atempurl.com${snapshot.data!.record!.imgUrl}'),
                                  radius: 25.r,
                                );
                              }else {
                                return Center(
                                  child: SizedBox(
                                      height: 15.h,
                                      width: 15.h,
                                      child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor), strokeWidth: .6.r,)),
                                );
                              }
                            },
                          ),
                          Gap(10.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                      )),
                                ],
                              ),

                              userData.read('isLogged') == false ?Text(userData.read('name')):  FutureBuilder(
                                future: accountDetail(),
                                builder: (context,snapshpt){
                                  if(snapshpt.hasData){
                                    return Text(
                                      '${snapshpt.data!.record!.name}',
                                    );
                                  }else {
                                    return Center(
                                      child: SizedBox(
                                          height: 15.h,
                                          width: 15.h,
                                          child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor), strokeWidth: .6.r,)),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 25.sp,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 4.r,
                          )
                        ],
                      ),
                    ],
                  ),
                ),


                Gap(15.h),
                Container(
                  height: 520.h,
                  width: double.infinity,
                  color: Color(0xffF7F7F7),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Gap(10.h),



                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.h ),
                          child: SizedBox(
                            height: 400.h,
                            child: ListView.separated(
                              itemBuilder: (context,index)=>Container(
                                height: 75.h,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 5.h),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Styles.defaultColor5,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,


                                  children: [
                                    Text( LocaleKeys.There_are_no_notifications.tr(),style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),),

                                    // CircleAvatar(
                                    //   backgroundColor: Styles.defualtColor6,
                                    //   radius: 28.r,
                                    //  ),
                                    // Gap(10.h),
                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //
                                    //
                                    //
                                    //
                                    //   ],
                                    // )

                                  ],
                                ),
                              ),
                              separatorBuilder: (context,index)=>Gap(5.h),
                              itemCount: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}
