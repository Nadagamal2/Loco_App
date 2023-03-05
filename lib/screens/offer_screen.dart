import 'dart:convert';

 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
 
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../models/profileDataModel.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../component/app_styles.dart';
import 'notification_screen.dart';
class OfferScreen extends StatefulWidget {
  String title;
  String storeLink;
  String storeimg;
  String storedetails;
  String storeAddress;
  String storephone;
  String stor_SaleCode;
  bool storevip;

    OfferScreen({

      Key? key,
      required this.title,
      required this.storeAddress,
      required this.storedetails,
      required this.storeimg,
      required this.storeLink,
      required this.storephone,
      required this.storevip,
      required this.stor_SaleCode,



    }) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future<ProfileDataModel?> accountDetail() async {
    try{
      var response = await http.post(
        Uri.parse('http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),

      );

      if (response.statusCode == 200) {
        var data=jsonDecode(response.body.toString());
        print('date=${data}');
        return ProfileDataModel .fromJson(data);


      } else {
        print('fail');
      }
    }catch(e){
      print('e=${e}');
    }
  }
  final userData =GetStorage();
  int counter=0;
  int counter1=0;
  List<AssetImage>iconImage2=[
    AssetImage('assets/vvv.jpg'),
    AssetImage('assets/vvv.jpg'),
    AssetImage('assets/vvv.jpg'),
    AssetImage('assets/vvv.jpg'),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF6F5F5),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 125.h,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.only(top: 40.h, right: 20.h, left: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              userData.read('isLogged') == false
                                  ? CircleAvatar(
                                backgroundImage:
                                NetworkImage('${userData.read('img')}'),


                                radius: 25.r,
                              )
                                  : FutureBuilder(
                                future: accountDetail(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'http://eibtekone-001-site18.atempurl.com${snapshot.data!.record!.imgUrl}'),
                                      radius: 25.r,
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
                                                AlwaysStoppedAnimation<
                                                    Color>(
                                                    Styles.defualtColor),
                                                strokeWidth: .6.r,
                                              )),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
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
                        ],
                      ),
                    ),
                    Gap(15.h),
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 20.h),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(LocaleKeys.Offers.tr(),),
                              Gap(4.h),
                              Container(
                                height: 2.h,
                                width: 100.h,
                                color: Styles.defualtColor3,
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Column(
              children: [


                Padding(
                  padding: EdgeInsets.only(top: 145.h, right: 20.h, left: 20.h),
                  child: Container(
                    height: 300.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Color(0xffF7F7F7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],

                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 75.h,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: Styles.defaultColor5,

                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.h),topLeft: Radius.circular(10.h)),
                                ),
                                child: Row(

                                  children: [
                                    Image(image: NetworkImage('${widget.storeimg}')),
                                    Gap(10.h),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              widget.title,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp),
                                            ),

                                            // Text(
                                            //   'vvv',
                                            //   style: TextStyle(
                                            //       color: Colors.grey.shade400,
                                            //       fontSize: 10.sp),
                                            // ),
                                            // Gap(5.h),
                                            // RatingBar.builder(
                                            //   initialRating: rating,
                                            //   minRating: 1,
                                            //   itemSize: 11,
                                            //   itemPadding:
                                            //   EdgeInsets.symmetric(horizontal: 1),
                                            //   itemBuilder: (context, _) => Icon(
                                            //     Icons.star,
                                            //     color: Colors.yellow.shade300,
                                            //     size: 15.sp,
                                            //   ),
                                            //   updateOnDrag: true,
                                            //   onRatingUpdate: (rating)  {},
                                            // ),
                                          ],
                                        ),
                                        Gap(3.h),
                                        Row(
                                          children: [
                                            Text(
                                              LocaleKeys.Store_link.tr(),
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color:
                                                Colors.grey.shade400,
                                              ),
                                            ),
                                            Gap(5.h),
                                            Icon(
                                              Icons
                                                  .arrow_forward_ios_outlined,
                                              size: 10.sp,
                                              color: Colors.grey.shade400,
                                            ),
                                            Gap(5.h),
                                            InkWell(
                                              onTap: () {
                                                _launchUrl(
                                                    '${ widget.storeLink}');
                                              },
                                              child: Text(
                                                '${widget.storeLink}',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors
                                                      .grey.shade400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(3.h),
                                        Text(
                                          '${widget.storedetails}',
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                              Gap(1.5.h),
                              Container(
                                height: 223.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Styles.defaultColor5,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15.h),bottomLeft: Radius.circular(15.h)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [
                                        Text( LocaleKeys.Offered_discount_code.tr(),style: TextStyle(
                                          color: Styles.defualtColor3,
                                          fontSize: 13.sp
                                        ),),
                                        Gap(30.h),
                                        Container(
                                          height: 30.h,
                                          width: 1.h,
                                          color: Color(0xffF7F7F7),
                                        ),
                                        Gap(30.h),
                                        SelectableText(widget.stor_SaleCode,style: TextStyle(
                                          color: Styles.defualtColor4,
                                        ),),

                                      ],
                                    ),
                                    // Gap(7.h),
                                    // CarouselSlider(
                                    //     options: CarouselOptions(
                                    //       height: 160.h,
                                    //
                                    //       autoPlay: false,
                                    //       viewportFraction: .7.h,
                                    //       onPageChanged: (index, reason) {
                                    //         setState(() {
                                    //           counter1=index;
                                    //
                                    //         });
                                    //       },
                                    //       enlargeCenterPage: false,
                                    //
                                    //       autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                    //       pauseAutoPlayOnTouch: true,
                                    //       //enableInfiniteScroll: true,
                                    //       autoPlayAnimationDuration: Duration(milliseconds: 900),
                                    //       //  viewportFraction: .8,
                                    //     ),
                                    //     items:   [
                                    //       for(int i=0;i<iconImage2.length;i++)
                                    //         Column(
                                    //           children: [
                                    //             Container(
                                    //
                                    //               decoration: BoxDecoration(
                                    //                 color: Colors.white,
                                    //                 borderRadius: BorderRadius.circular(30.h),
                                    //                 image: DecorationImage(
                                    //                   fit: BoxFit.cover,
                                    //                   image: iconImage2[i],
                                    //                 ),
                                    //               ),
                                    //               margin: EdgeInsets.symmetric(horizontal: 10.h),
                                    //               height: 130.h,
                                    //               width:  250.h,
                                    //             ),
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.center,
                                    //               children: [
                                    //                 for(int i=0;i<iconImage2.length;i++)
                                    //                   Container(
                                    //                     height: 6.h,
                                    //                     width: 6.h,
                                    //                     margin: EdgeInsets.symmetric(horizontal: 3.h,vertical: 10.h),
                                    //                     decoration: BoxDecoration(
                                    //                       color: counter1==i?Styles.defualtColor:Styles.defaultColor7,
                                    //                       shape: BoxShape.circle,
                                    //
                                    //                     ),
                                    //                   ),
                                    //               ],
                                    //             ),
                                    //
                                    //
                                    //           ],
                                    //         )]
                                    //
                                    // ),
                                 
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height:35.h,
                                              width:71.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(LocaleKeys.Store_name.tr(),style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height:35.h,
                                              width:217.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(widget.title,style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height:35.h,
                                              width:71.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(LocaleKeys.Address.tr(),style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height:35.h,
                                              width:217.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(widget.storeAddress,style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height:35.h,
                                              width:71.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(LocaleKeys.Contact_Number.tr(),style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height:35.h,
                                              width:217.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(widget.storephone,style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Container(
                                        //       height:30.h,
                                        //       width:71.h,
                                        //       decoration: BoxDecoration(
                                        //           border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                        //       ),
                                        //       child: Center(
                                        //         child: Text(LocaleKeys.Link.tr(),style: TextStyle(
                                        //           fontSize: 12.sp,
                                        //           fontWeight: FontWeight.w600,
                                        //         ),),
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       height:30.h,
                                        //       width:217.h,
                                        //       decoration: BoxDecoration(
                                        //           border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                        //       ),
                                        //       child: Center(
                                        //         child: Text( widget.storeLink,style: TextStyle(
                                        //           fontWeight: FontWeight.w600,
                                        //         ),),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height:48.h,
                                              width:71.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(LocaleKeys.Supports_VIP_card.tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height:48.h,
                                              width:217.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade500,width: .1.r,)
                                              ),
                                              child: Center(
                                                child: Text(widget.storevip?LocaleKeys.Support.tr():LocaleKeys.Not_Support.tr(),style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
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
  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
