import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../component/app_styles.dart';
import '../models/getAllCategory_model.dart';
import '../models/search.dart';
import '../translations/locale_keys.g.dart';
import 'offer_screen.dart';

class search extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';

          },
          icon: Icon(Icons.close))
    ];
  }
  @override
  String get searchFieldLabel =>LocaleKeys.Search_for_specific_store.tr();

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
          toolbarHeight: 65.h,
          color: Colors.grey,
          elevation: 0

      ),
      textSelectionTheme: TextSelectionThemeData(

          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white),

      inputDecorationTheme: InputDecorationTheme(


        hintStyle: TextStyle(
          color: Colors.white,
        ),
        isDense: true,
        contentPadding:
        EdgeInsets.fromLTRB(10.h, 5.h, 10.h, 7.h),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  List data = [];
  List<CategoryIdallSearchModel> result = [];
  Future<List<CategoryIdallSearchModel>?> catidSearch({  String? query}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"SearchValue":query}));
      var dataa = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        data=dataa['records'];
         result=data.map((e) => CategoryIdallSearchModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
              query.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        print('dataId==${data}');
        print('result==${result}');
      } else {
        print("Faild");
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }
  void getDataId({required dynamic id}) async{

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
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder <List<CategoryIdallSearchModel>?>(
      future: catidSearch(query: query),
      builder: (context, snapshot){

        if (snapshot.hasData) {
          List<CategoryIdallSearchModel>? item = snapshot.data;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SizedBox(
              height: 400.h,
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  height: 75.h,
                  width: double.infinity,
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Styles.defaultColor5,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      getDataId(id: item[index].id);
                      Get.to(OfferScreen(
                        stor_SaleCode: '${item[index].saleCode}',
                        title: item[index].title!,
                        storeAddress: '${item[index].storAddress}',
                        storedetails:
                        '${item[index].details}',
                        storeimg: 'http://eibtekone-001-site18.atempurl.com/${item[index].imgUrl}',
                        storeLink: '${item[index].link}',
                        storephone: '${item[index].phoneNumber}',
                        storevip: item[index].acceptLocoCard!,
                      ));
                    },
                    child: Row(
                      children: [
                        Image(
                            height: 50.h,
                            width: 50.h,
                            image: NetworkImage(
                              'http://eibtekone-001-site18.atempurl.com/${item[index].imgUrl }',
                            )),
                        Gap(10.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${item[index].title}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp
                                  ),
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
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Gap(5.h),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 10.sp,
                                  color: Colors.grey.shade400,
                                ),
                                Gap(5.h),
                                InkWell(
                                  onTap: (){_launchUrl('${item[index].link}');},
                                  child: Text(
                                    '${item[index].link}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(3.h),
                            Text(
                              '${item[index].details}',
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
                separatorBuilder: (context, index) => Gap(5.h),
                itemCount: item!.length,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          );
        }
      },
    );
  }
  final userData =GetStorage();
  Future<CategoryIdallModel?> catid({  String? query}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/GetAllStores/${ userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"SearchValue":''}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdallModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }
  double rating=0;

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder (
      future: catid(),
      builder: (context, snapshot){


        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SizedBox(
              height: 400.h,
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  height: 75.h,
                  width: double.infinity,
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
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
                      getDataId(id: snapshot.data!.records[index].id);
                      Get.to(OfferScreen(
                        stor_SaleCode: '${snapshot.data!.records[index].storSaleCode}',
                        title: snapshot
                            .data!.records[index].storTitle,
                        storeAddress: '${snapshot.data!.records[index].storAddress}',
                        storedetails:
                        '${snapshot.data!.records[index].storDeteils}',
                        storeimg: 'http://eibtekone-001-site18.atempurl.com/${snapshot.data!.records[index].storImgUrl}',
                        storeLink: '${snapshot.data!.records[index].storLink}',
                        storephone: '${snapshot.data!.records[index].storPhoneNumber}',
                        storevip: snapshot.data!.records[index].acceptLocoCard,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${snapshot.data!.records[index].storTitle}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp
                                  ),
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
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Gap(5.h),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 10.sp,
                                  color: Colors.grey.shade400,
                                ),
                                Gap(5.h),
                                InkWell(
                                  onTap: (){_launchUrl('${snapshot.data!.records[index].storLink}');},
                                  child: Text(
                                    '${snapshot.data!.records[index].storLink}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey.shade400,
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
                separatorBuilder: (context, index) => Gap(5.h),
                itemCount: snapshot.data!.records.length,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          );
        }
      },
    );
  }
  Future<void> _launchUrl(String link ) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}