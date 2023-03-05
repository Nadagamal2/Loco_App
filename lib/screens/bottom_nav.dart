
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:loco/screens/profile_screen.dart';

import '../component/app_styles.dart';
import '../translations/locale_keys.g.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'offer_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  var currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:_wigetOptions[currentIndex] ,
      bottomNavigationBar: Container(
        //margin: EdgeInsets.all(20),
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.r),topRight: Radius.circular(50.r) ),
        ),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal:  59.h),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
               children: [
                SizedBox(
                  width: screenWidth * .2125,
                  child: Center(
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 900),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index==currentIndex?100.h:0,
                      //index == currentIndex ? screenWidth * .12 : 0,
                      width:index==currentIndex?61.h:0,
                      //index == currentIndex ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                      boxShadow: [
                        index==currentIndex?
                        BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 2,
                            spreadRadius: 1,

                          ):
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 3,
                          spreadRadius: 2,

                        )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,

                          colors: [
                            Color(0xffffa36c),
                            Styles.defualtColor,

                          ],
                        ),

                        color: index == currentIndex
                            ? Styles.defualtColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r) ),
                      ),
                    ),
                  ),
                ),
                index==currentIndex?
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,

                  child:  iconImage[index]
                  // Icon(
                  //   listOfIcons[index],
                  //   size: 35.sp,
                  //   color:Colors.white,
                  //
                  // ),

                ):
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconImage2[index]
                      // Image(
                      //  // fit: BoxFit.cover,
                      //   height: 15.h,
                      //   width: 15.h,
                      //   image: iconImage[index],
                      // ),
                      ,
                      Gap(3.h),
                      // Icon(
                      //   listOfIcons[index],
                      //   size: 25.sp,
                      //   color: index == currentIndex
                      //       ? Colors.white
                      //       : Colors.black45,
                      // ),
                      Text(listLable[index].tr(),style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black45,


                      ),)
                      ,
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<IconData> listOfIcons = [
  //
  //   Icons.person_outline_rounded,
  //   Icons.notifications_none_outlined,
  //    FluentSystemIcons.ic_fluent_home_regular
  // ];
  static final List<Widget> _wigetOptions=<Widget>[



    ProfileScreen(),
    HomeScreen(),
    NotificationScreen(),

  ];
  static final List<String>listLable=[

   "Profile".tr(),
     "Home".tr(),
    "Notifications".tr(),


  ];

  List<SvgPicture>iconImage=[
    SvgPicture.asset(
        'assets/user icon.svg',

    ),
    SvgPicture.asset(
        'assets/Icon-house.svg',

    ),
    SvgPicture.asset(
        'assets/notification-3-line.svg',

    ),



  ]; List<SvgPicture>iconImage2=[
    SvgPicture.asset(
      'assets/33.svg',

    ),
    SvgPicture.asset(
        'assets/11.svg',

    ),
    SvgPicture.asset(
        'assets/22.svg',

    ),




  ];
  // List<AssetImage>iconImage2=[
  //   AssetImage('assets/aaa.png'),
  //   AssetImage('assets/ddd.png'),
  //
  //   AssetImage('assets/bbb.png'),
  //
  // ];
}

//FluentSystemIcons.ic_fluent_person_regular