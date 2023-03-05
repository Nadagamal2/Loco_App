 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import '../component/app_styles.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
  class PayScreen extends StatelessWidget {
  const PayScreen({Key? key}) : super(key: key);

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
                padding: EdgeInsets.only(top: 100.h, right: 20.h, left: 20.h),
                child:  Center(
                  child: Column(
                    children: [
                      Container(
                        height: 150.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Styles.defaultColor5,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],

                        ),
                        child: Center(
                          child: Text(
                           LocaleKeys.The_stores_does_not_offer_online_payment.tr(),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
