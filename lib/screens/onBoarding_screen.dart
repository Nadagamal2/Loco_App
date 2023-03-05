
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loco/screens/signIn_screen.dart';
import 'package:loco/screens/sign_up_screen.dart';
 import '../component/app_styles.dart';
import '../component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import '../translations/locale_keys.g.dart';



class BoardingModel {
  final String image;
  final String title;
  // final String body;

  BoardingModel({
    required this.image,
    required this.title,
    // required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/1.png',
      title: 'العنوان الأول',
      // body: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحه,\n لقد تم توليد هذا النص ',
    ),
    BoardingModel(
      image: 'assets/2.png',
      title: 'العنوان الثاني',
      // body: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحه,\n لقد تم توليد هذا النص ',
    ),
    BoardingModel(
      image: 'assets/3.png',
      title: 'العنوان الثالث',
      // body: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحه,\n لقد تم توليد هذا النص ',
    ),
  ];
  int currentIndex = 0;
  int currentIndex1 = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(40.h),
              Text(
                "Loco App",
                style: Styles.headLine2,
              ),
              SizedBox(
                height: 400.h,
                child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                        currentIndex1=index;
                      });
                    },
                    physics: BouncingScrollPhysics(),
                    itemCount: boarding.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:   EdgeInsets.only(right: 25.h,left: 25.h),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [





                              Image(
                                fit: BoxFit.cover,
                                image: AssetImage(boarding[index].image),
                              ),
                              Gap(10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for(int i=0;i<boarding.length;i++)
                                    Container(
                                      height:i==currentIndex1? 8.h:4.h,
                                      width: i==currentIndex1?8.h:4.h,
                                      margin: EdgeInsets.symmetric(horizontal: 5.h,vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: i==currentIndex1? Styles.defualtColor:Colors.black,
                                        shape: BoxShape.circle,

                                      ),
                                    ),
                                ],
                              ),



                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Gap(15.h),
              Padding(
                padding:   EdgeInsets.symmetric(horizontal: 25.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildBottum(
                          height: 48,
                          decoration: BoxDecoration(

                            border: Border.all(color:Styles.defualtColor,width: .5.h ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 140,

                          text: Text(
                          LocaleKeys.LOG_IN.tr(),
                            style: TextStyle(
                              color: Styles.defualtColor,
                              fontSize: 16.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Get.to(SignInScreen());
                            print('object');


                          },
                        ),
                        buildBottum(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Styles.defualtColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 140,

                          text: Text(
                            LocaleKeys.sign_Up.tr(),
                            style: TextStyle(
                              color: Styles.defaultColor5,
                              fontSize: 16.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Get.to(SignupScreen());
                          },
                        ),
                      ],
                    ),
                    Gap(20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(SignInScreen());

                            },

                            child: Text(LocaleKeys.Skip.tr(),style: Styles.headLineGray1.copyWith(fontSize: 19.sp),)),

                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        ));
  }
}
