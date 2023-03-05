

import 'package:easy_localization/easy_localization.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:gap/gap.dart';

import '../component/app_styles.dart';



class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30.sp,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                        'assets/check.png',
                        fit: BoxFit.cover,
                        height: 200.h,
                        width: 200.h,
                       )),
                  Gap(20.h),
                  Text(
                     'Check Your Email !',
                    style: TextStyle(
                      color: Styles.defualtColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),




                  Gap(230.h),

                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back".tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
