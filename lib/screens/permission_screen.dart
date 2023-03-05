import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../component/app_styles.dart';
import '../models/privacypolicy_model.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  Future<PolicyModel> getData() async {
    final response = await http.get(Uri.parse(
        'http://eibtekone-001-site18.atempurl.com/api/GetAll_privacypolicy'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      return PolicyModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            )),
        centerTitle: true,
        title: Text(
          LocaleKeys.Terms_and_Conditions.tr(),
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Container(
            //   height: 690.h,
            //   width: double.infinity,
            //   color: Colors.white,
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 45.h, right: 20.h, left: 20.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       InkWell(
            //         child: Icon(
            //           Icons.arrow_forward,
            //           size: 25.sp,
            //         ),
            //         onTap: () {
            //           Get.back();
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
                padding: EdgeInsets.only(top: 10.h, right: 20.h, left: 20.h),
                child: Center(
                  child: Column(
                    children: [
                      // Text(
                      //   LocaleKeys.Terms_and_Conditions.tr(),
                      //   style: TextStyle(
                      //     fontSize: 18.h,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // Gap(10.h),
                      FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data!.records[0].deatils}',
                              style: TextStyle(
                                fontSize: 15.h,
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Styles.defualtColor),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
