import 'dart:convert';


import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
 import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:loco/screens/search.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/app_styles.dart';
import '../models/categoryID.dart';
import '../models/category_model.dart';
import '../models/profileDataModel.dart';
 import '../translations/locale_keys.g.dart';
import 'notification_screen.dart';
import 'offer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<CategoryIdModel> categoryid({int? id}) async {
  //   final response = await http.get(Uri.parse(
  //       'http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${userData.read('id')}'));
  //
  //   var data = jsonDecode(response.body.toString());
  //
  //   if (response.statusCode == 200) {
  //     print(response.body.length);
  //
  //     print(data);
  //     return CategoryIdModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }
  Future<CategoryIdModel?> catid({int? id, String? countId}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${id}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"count_id": countId}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProfileDataModel?> accountDetail() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('date=${data}');
        return ProfileDataModel.fromJson(data);
      } else {
        print('fail');
      }
    } catch (e) {
      print('e=${e}');
    }
  }

  void getDataId({required dynamic id}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/Get_Store_byId/${id}'),
          body: jsonEncode({"id": id}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final userData = GetStorage();
  int count = 0;
  int? id;

  // Future<CategoryModel> getDataCategory() async {
  //   final response = await http.get(
  //       Uri.parse('http://eibtekone-001-site18.atempurl.com/api/GetAllCategories'));
  //   var data = jsonDecode(response.body.toString());
  //
  //   if (response.statusCode==200) {
  //
  //     print(response.body);
  //     return CategoryModel.fromJson(jsonDecode(response.body));
  //   } else {
  //
  //     throw Exception('Failed to load album');
  //   }
  // }
  Future<List<CategoryModel>> fetchCategory() async {
    final response = await http.get(Uri.parse(
        'http://eibtekone-001-site18.atempurl.com/api/GetAllCategories'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List jsonData = (data['records']);

      return jsonData
          .map((categoryData) => CategoryModel.fromJson(categoryData))
          .toList();
    } else {
      throw Exception('Failed to load clinics');
    }
  }

  // Future categoryId({String? countId, int? id}) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //           'http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${id}'));
  //   request.body = json.encode({"count_id": countId});
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse StreamedResponse = await request.send();
  //   var response = await http.Response.fromStream(StreamedResponse);
  //   final result = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     print(result['records'][0]['stor_ImgUrl']);
  //     userData.write('title', result['records'][0]['stor_Title']);
  //     print(userData.read('title'));
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   return result;
  // }

  // Future<CategoryIdModel?> categoryId( ) async {
  //
  //   var headers = {
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request('GET', Uri.parse('http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${userData.read('id')}'));
  //   request.body = json.encode({
  //     "count_id": userData.read('id')
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print('data=${await response.stream.bytesToString()}');
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  //   // var headers = {
  //   //   'Content-Type': 'application/json'
  //   // };
  //   // var request = http.Request('POST', Uri.parse('http://eibtekone-001-site11.atempurl.com/api/GetclincbyId'));
  //   // request.body = json.encode({
  //   //   "id":id
  //   // });
  //   // request.headers.addAll(headers);
  //   //
  //   //
  //   // http.StreamedResponse response = await request.send();
  //   //
  //   // if (response.statusCode == 200) {
  //   //    print(await response.stream.bytesToString());
  //   //   Get.to(BookDoctorScreen(id: id, ));
  //   //   print('id=${id}');
  //   //
  //   // }
  //   // else {
  //   //   print(response.reasonPhrase);
  //   // }
  // }
  // Future<CategoryIdModel?> categorydId({int? id}) async {
  //
  //   final response = await http.get(
  //       Uri.parse(
  //       'http://eibtekone-001-site18.atempurl.com/api/GetAllStores/lll'),
  //     headers: {
  //   "Content-Type": "application/json",
  //   },
  //   );
  //
  //   var data = jsonDecode(response.body.toString());
  //
  //   if (response.statusCode == 200) {
  //     print(response.body.length);
  //
  //     print('data');
  //     return CategoryIdModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  //
  // }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Column(
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
              Gap(10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: search());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF6F5F5),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    height: 45.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          FluentSystemIcons.ic_fluent_search_regular,
                          color: Colors.grey.shade400,
                          size: 17.sp,
                        ),
                        Gap(10.h),
                        Text(
                          LocaleKeys.Press_here_to_search.tr(),
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.h),
              //   child: TextFormField(
              //     onTap: (){
              //       showSearch(context: context, delegate: search());
              //     },
              //     cursorColor: Colors.grey.shade400,
              //     keyboardType: TextInputType.emailAddress,
              //     decoration: InputDecoration(
              //         floatingLabelBehavior: FloatingLabelBehavior.never,
              //         isDense: true,
              //         contentPadding:
              //             EdgeInsets.fromLTRB(20.h, 0.h, 20.h, 0.h),
              //         filled: true,
              //         fillColor: Color(0xffF6F5F5),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //               width: .1.r, color: Colors.transparent),
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         border: OutlineInputBorder(),
              //         prefixIcon: Icon(
              //           FluentSystemIcons.ic_fluent_search_regular,
              //           color: Colors.grey.shade400,
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //               width: .1.r, color: Colors.transparent),
              //           borderRadius: BorderRadius.circular(15.r),
              //         ),
              //         labelText: 'ابحث عن متجر معين',
              //         hintText: 'ابحث عن متجر معين',
              //         labelStyle: TextStyle(
              //             fontSize: 15.sp, color: Colors.grey.shade400),
              //         hintStyle: TextStyle(
              //             fontSize: 15.sp, color: Colors.grey.shade400)),
              //   ),
              // ),
              Gap(15.h),
              Container(
                height: 459.h,
                width: double.infinity,
                color: Color(0xffF7F7F7),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.h, vertical: 10.h),
                        child: FutureBuilder<List<CategoryModel?>>(
                          future: fetchCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<CategoryModel?>? item = snapshot.data;

                              return SizedBox(
                                width: 300.h,
                                height: 30.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            id = item[index]?.id;
                                            userData.write('id', id);

                                            catid(
                                                countId:
                                                '${userData.read('country')}',
                                                id: userData.read('id'));

                                            print(item[index]?.id);
                                            print(userData.read('country'),);
                                          });
                                        },
                                        child: Container(
                                          height: 30.h,
                                          width: 85.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            gradient: LinearGradient(
                                              // begin: Alignment.topRight,
                                              // end: Alignment.bottomRight ,

                                              colors: [
                                                Color(0xffffa36c),
                                                Styles.defualtColor,
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${item![index]!.categName}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  itemCount: item!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(10.h);
                                  },
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
                      ),
                      FutureBuilder(
                        future: catid(
                          countId:'${ userData.read('country')}',
                          id: userData.read('id'),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: SizedBox(
                                height: 400.h,
                                child: ListView.separated(
                                  itemBuilder: (context, index) => Container(
                                    height: 75.h,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.h, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: Styles.defaultColor5,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        // showDialog(
                                        //   context: context,
                                        //   builder:(context)=>
                                        //       Dialog(
                                        //         shape: RoundedRectangleBorder(
                                        //             borderRadius: BorderRadius.circular(30)),
                                        //
                                        //         child: Container(
                                        //           height: 210,
                                        //           width: 250,
                                        //
                                        //           child: Column(
                                        //             mainAxisAlignment: MainAxisAlignment.center,
                                        //             children: [
                                        //               Text('قم بإضافة رأيك',style: TextStyle(
                                        //                 fontWeight: FontWeight.w500,
                                        //                 fontSize: 17.sp,
                                        //               ),),
                                        //               Text('يرجي تقييم الخدمة وإضافة رأيك في العملية  ',style: TextStyle(
                                        //                 fontWeight: FontWeight.w500,
                                        //                 color: Styles.defualtColor2,
                                        //                 fontSize: 14.sp,
                                        //               ),),
                                        //               Gap(10.h),
                                        //               RatingBar.builder(
                                        //                 initialRating: rating,
                                        //                 minRating: 1,
                                        //                 itemSize: 30,
                                        //                 itemPadding: EdgeInsets.symmetric(horizontal: 2),
                                        //                 itemBuilder: (context,_)=>Icon(
                                        //                   Icons.star,
                                        //                   color: Colors.yellow.shade300,
                                        //                   size: 18.sp,
                                        //                 ),
                                        //                 updateOnDrag: true,
                                        //                 onRatingUpdate: (rating)=>setState(() {
                                        //                   this.rating=rating;
                                        //                 }),
                                        //               ),
                                        //               Gap(20.h),
                                        //               InkWell(
                                        //                 onTap: (){
                                        //                   Get.back();
                                        //                 },
                                        //                 child: Container(
                                        //                   height: 40.h,
                                        //                   width: 100.h,
                                        //                   decoration: BoxDecoration(
                                        //                     borderRadius: BorderRadius.circular(5.h),
                                        //                     color: Styles.defualtColor,
                                        //                   ),
                                        //                 child: Icon(Icons.send,color: Colors.white,),
                                        //                 ),
                                        //               )
                                        //
                                        //             ],
                                        //           ),
                                        //         ),
                                        //
                                        //       ),
                                        //
                                        // );
                                        getDataId(
                                            id: snapshot
                                                .data!.records[index].id);
                                        Get.to(OfferScreen(
                                          title: snapshot
                                              .data!.records[index].storTitle,
                                          storeAddress: '${snapshot.data!.records[index].storAddress}',
                                          storedetails:
                                              '${snapshot.data!.records[index].storDeteils}',
                                          storeimg: 'http://eibtekone-001-site18.atempurl.com/${snapshot.data!.records[index].storImgUrl}',
                                          storeLink: '${snapshot.data!.records[index].storLink}',
                                          storephone: '${snapshot.data!.records[index].storPhoneNumber}',
                                          storevip: snapshot.data!.records[index].acceptLocoCard,
                                          stor_SaleCode: '${snapshot.data!.records[index].storSaleCode}',
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          Image(
                                              height: 50.h,
                                              width: 50.h,
                                              image: NetworkImage(
                                                'http://eibtekone-001-site18.atempurl.com/${snapshot.data!.records[index].storImgUrl}',
                                              )),
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
                                                    '${snapshot.data!.records[index].storTitle}',
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
                                                          '${snapshot.data!.records[index].storLink}');
                                                    },
                                                    child: Text(
                                                      '${snapshot.data!.records[index].storLink}',
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
                                                '${snapshot.data!.records[index].storDeteils}',
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
                                  ),
                                  separatorBuilder: (context, index) =>
                                      Gap(5.h),
                                  itemCount: snapshot.data!.records.length,
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'choose Category Above',
                                style: TextStyle(
                                    color: Styles.defualtColor,
                                    fontSize: 15.sp),
                              ),
                            );
                          }
                        },
                      )
                      // FutureBuilder(
                      //   future: categoryId(),
                      //
                      //     builder: (context,snapshot){
                      //     if(snapshot.hasData){
                      //       return Text('fff${snapshot.data['records'][0]['stor_Title']}');
                      //     }
                      //     else{
                      //       return CircularProgressIndicator();
                      //     }
                      //
                      //     })
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}

// Container(
//                                           height: 30.h,
//                                           width: 85.h,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(20.r),
//                                             gradient: LinearGradient(
//                                               // begin: Alignment.topRight,
//                                               // end: Alignment.bottomRight ,
//
//                                               colors: [
//                                                 Colors.grey.shade300,
//                                                 Colors.grey.shade400,
//                                               ],
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'الأسر المنتجة',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12.sp,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
