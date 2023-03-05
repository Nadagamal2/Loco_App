//  import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:loco/screens/sign_up_screen.dart';
//
// import '../component/app_styles.dart';
// import '../component/component.dart';
//
//
// class BoardingModel {
//   final String image;
//   final String title;
//   final String body;
//
//   BoardingModel({
//     required this.image,
//     required this.title,
//     required this.body,
//   });
// }
//
// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }
//
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   var boardController = PageController();
//   List<BoardingModel> boarding = [
//     BoardingModel(
//       image: 'assets/1.png',
//       title: 'العنوان الأول',
//       body: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحه,\n لقد تم توليد هذا النص ',
//     ),
//     BoardingModel(
//       image: 'assets/2.png',
//       title: 'العنوان الثاني',
//       body: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحه,\n لقد تم توليد هذا النص ',
//     ),
//     BoardingModel(
//       image: 'assets/3.png',
//       title: 'العنوان الثالث',
//       body: 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحه,\n لقد تم توليد هذا النص ',
//     ),
//   ];
//   int currentIndex = 0;
//   int currentIndex1 = 0;
//   PageController? _controller;
//
//   @override
//   void initState() {
//     _controller = PageController(initialPage: 0);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                   padEnds: false,
//                   controller: _controller,
//                   onPageChanged: (int index) {
//                     setState(() {
//                       currentIndex = index;
//                       currentIndex1=index;
//                     });
//                   },
//                   physics: BouncingScrollPhysics(),
//                   itemCount: boarding.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding:   EdgeInsets.only(right: 25.h,left: 25.h),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               boarding[index].title,
//                               style: Styles.headLine2,
//                             ),
//                             Gap(10.h),
//
//                             Text(
//                               boarding[index].body,
//                               style: Styles.headLine3,
//                               textAlign: TextAlign.center,
//                             ),
//                             Gap(35.h),
//                             Image(
//                               fit: BoxFit.cover,
//                               image: AssetImage(boarding[index].image),
//                             ),
//                             Gap(10.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 for(int i=0;i<boarding.length;i++)
//                                   Container(
//                                     height:i==currentIndex1? 8.h:4.h,
//                                     width: i==currentIndex1?8.h:4.h,
//                                     margin: EdgeInsets.symmetric(horizontal: 5.h,vertical: 10.h),
//                                     decoration: BoxDecoration(
//                                       color: i==currentIndex1? Styles.defualtColor:Colors.black,
//                                       shape: BoxShape.circle,
//
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             Gap(20.h),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 buildBottum(
//                                   height: 45,
//                                   decoration: BoxDecoration(
//
//                                     border: Border.all(color:Styles.defualtColor,width: .5.h ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   width: 140,
//
//                                   text: Text(
//                                     "تسجيل الدخول",
//                                     style: TextStyle(
//                                       color: Styles.defualtColor,
//                                       fontSize: 16.sp,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   onTap: () {
//
//
//                                   },
//                                 ),
//                                 buildBottum(
//                                   height: 45,
//                                   decoration: BoxDecoration(
//                                     color: Styles.defualtColor,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   width: 140,
//
//                                   text: Text(
//                                     "حساب جديد",
//                                     style: TextStyle(
//                                       color: Styles.defaultColor5,
//                                       fontSize: 16.sp,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   onTap: () {
//                                     Get.to(SignupScreen());
//                                   },
//                                 ),
//                               ],
//                             ),
//                             Gap(20.h),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                     onTap: () {
//
//                                     },
//
//                                     child: Text('تخطي',style: Styles.headLineGray1.copyWith(fontSize: 19.sp),)),
//
//                               ],
//                             )
//
//
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             // if (currentIndex == boarding.length - 3)
//             //   buildBottum(
//             //     //EdgeInsets.symmetric(vertical: 55)
//             //     margin: EdgeInsets.symmetric(vertical: 0),
//             //     height: 43,
//             //     decoration: BoxDecoration(
//             //       color: Styles.defualtColor,
//             //       borderRadius: BorderRadius.circular(14),
//             //     ),
//             //     width: 190,
//             //
//             //     text: Text(
//             //       currentIndex == boarding.length - 1 ? 'Lets Go' : 'Next',
//             //       style: Styles.buttomStyle,
//             //       textAlign: TextAlign.center,
//             //     ),
//             //     onTap: () {
//             //       if (currentIndex == boarding.length - 1) {
//             //
//             //       }
//             //       _controller?.nextPage(
//             //         duration: Duration(seconds: 1),
//             //         curve: Curves.fastLinearToSlowEaseIn,
//             //       );
//             //     },
//             //   ),
//             // if (currentIndex == boarding.length - 2)
//             //   Padding(
//             //     padding: const EdgeInsets.symmetric(horizontal: 35),
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: [
//             //         buildBottum(
//             //           height: 43,
//             //           decoration: BoxDecoration(
//             //             color: Styles.defualtColor,
//             //             borderRadius: BorderRadius.circular(14),
//             //           ),
//             //           width: 130,
//             //           margin: EdgeInsets.symmetric(vertical: 55),
//             //           text: Text(
//             //             'previous',
//             //             style: Styles.buttomStyle,
//             //             textAlign: TextAlign.center,
//             //           ),
//             //           onTap: () {
//             //             if (currentIndex == boarding.length - 1) {
//             //
//             //             }
//             //             _controller?.previousPage(
//             //               duration: Duration(seconds: 1),
//             //               curve: Curves.fastLinearToSlowEaseIn,
//             //             );
//             //           },
//             //         ),
//             //         buildBottum(
//             //           height: 43,
//             //           decoration: BoxDecoration(
//             //             color: Styles.defualtColor,
//             //             borderRadius: BorderRadius.circular(14),
//             //           ),
//             //           width: 130,
//             //           margin: EdgeInsets.symmetric(vertical: 55),
//             //           text: Text(
//             //             currentIndex == boarding.length - 1 ? 'Lets Go' : 'Next',
//             //             style: Styles.buttomStyle,
//             //             textAlign: TextAlign.center,
//             //           ),
//             //           onTap: () {
//             //             if (currentIndex == boarding.length - 1) {
//             //
//             //             }
//             //             _controller?.nextPage(
//             //               duration: Duration(seconds: 1),
//             //               curve: Curves.fastLinearToSlowEaseIn,
//             //             );
//             //           },
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // if (currentIndex == boarding.length - 1)
//             //   Padding(
//             //     padding: const EdgeInsets.symmetric(horizontal:  0),
//             //     child: Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: [
//             //         buildBottum(
//             //           decoration: BoxDecoration(
//             //             color: Styles.defualtColor,
//             //             borderRadius: BorderRadius.circular(14),
//             //           ),
//             //           margin: EdgeInsets.symmetric(vertical: 55),
//             //           height: 43,
//             //           width: 130,
//             //           text: Text(
//             //             'previous',
//             //             style: Styles.buttomStyle,
//             //             textAlign: TextAlign.center,
//             //           ),
//             //           onTap: () {
//             //             _controller?.previousPage(
//             //               duration: Duration(seconds: 1),
//             //               curve: Curves.fastLinearToSlowEaseIn,
//             //             );
//             //           },
//             //         ),
//             //         buildBottum(
//             //           height: 43,
//             //           decoration: BoxDecoration(
//             //             color: Styles.defualtColor,
//             //             borderRadius: BorderRadius.circular(14),
//             //           ),
//             //           width: 130,
//             //           margin: EdgeInsets.symmetric(vertical: 55),
//             //           text: Text(
//             //             currentIndex == boarding.length - 1 ? 'Lets Go' : 'Next',
//             //             style: Styles.buttomStyle,
//             //             textAlign: TextAlign.center,
//             //           ),
//             //           onTap: () {
//             //             if (currentIndex == boarding.length - 1) {
//             //
//             //             }
//             //             _controller?.nextPage(
//             //               duration: Duration(seconds: 1),
//             //               curve: Curves.fastLinearToSlowEaseIn,
//             //             );
//             //           },
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//           ],
//         ));
//   }
// }
