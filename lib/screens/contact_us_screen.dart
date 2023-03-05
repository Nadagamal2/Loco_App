import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
 import 'package:easy_localization/easy_localization.dart';

import 'package:gap/gap.dart';
 import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../component/app_styles.dart';
import '../models/contact_us.dart';
import '../translations/locale_keys.g.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Future<ContactUs> getData() async {
    final response = await http.get(
        Uri.parse('http://eibtekone-001-site18.atempurl.com/api/Get_ContcatUs'));

    if (response.statusCode==200) {

      print(response.body);
      return ContactUs.fromJson(jsonDecode(response.body));
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
          LocaleKeys.Contact_Us.tr(),
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [


            Padding(
              padding: EdgeInsets.only(top: 10.h, right: 20.h, left: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 590.h,
                    width: 80.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/ee.png',
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Gap(10.h),
                  FutureBuilder(
                    future: getData(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.About_the_app.tr(),
                                style: TextStyle(
                                  color: Styles.defualtColor,
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.records![0].aboutApp}',
                                 style: TextStyle(
                                  fontSize: 11.sp,
                                ),
                                maxLines: 6,
                              ),
                              Gap(15.h),
                              Text(
                                LocaleKeys.our_Vision.tr(),
                                style: TextStyle(
                                  color: Styles.defualtColor,
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.records![0].ourVision}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                ),
                              ),
                              Gap(15.h),
                              Text(
                                LocaleKeys.our_Goals.tr(),
                                style: TextStyle(
                                  color: Styles.defualtColor,
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                '${snapshot.data!.records![0].ourGoals}',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                ),
                              ),
                              Gap(10.h),
                              InkWell(
                                onTap: (){
                                  _launchUrl('${snapshot.data!.records![0].insatLink}');
                                },
                                child: SvgPicture.asset('assets/instagram.svg',
                                    semanticsLabel: 'Acme Logo'),
                              ),
                              Gap(5.h),
                              InkWell(
                                onTap: (){
                                  _launchUrl('${snapshot.data!.records![0].faceebokkLink}');
                                },
                                child: SvgPicture.asset('assets/face.svg',
                                    semanticsLabel: 'Acme Logo'),
                              ),
                              Gap(5.h),
                              InkWell(
                                onTap: (){
                                  _launchUrl('${snapshot.data!.records![0].linkdLinLink}');
                                },
                                child: SvgPicture.asset('assets/linkedin.svg',
                                    semanticsLabel: 'Acme Logo'),
                              ),
                              Gap(5.h),
                              InkWell(
                                onTap: (){
                                  _launchUrl('${snapshot.data!.records![0].twitterLink}');
                                },
                                child: SvgPicture.asset('assets/twitter.svg',
                                    semanticsLabel: 'Acme Logo'),
                              ),
                            ],
                          ),
                        );
                      }else {
                        return Center(
                          child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
