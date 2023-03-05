// import 'dart:convert';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:copon/screens/offer_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
//  import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
//
// import '../component/app_styles.dart';
// import '../models/categoryID.dart';
// import '../translations/locale_keys.g.dart';
//
// class GetCategoryById extends StatefulWidget {
//
//     GetCategoryById({Key? key}) : super(key: key);
//
//   @override
//   State<GetCategoryById> createState() => _GetCategoryByIdState();
// }
//
// class _GetCategoryByIdState extends State<GetCategoryById> {
//   final userData =GetStorage();
//   // Future<CategoryIdModel> categoryId({int? id}) async {
//   //   final response = await http.get(Uri.parse(
//   //       'http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${userData.read('id')}'));
//   //
//   //   var data = jsonDecode(response.body.toString());
//   //
//   //   if (response.statusCode == 200) {
//   //     print(response.body.length);
//   //
//   //     print(data);
//   //     return CategoryIdModel.fromJson(jsonDecode(response.body));
//   //   } else {
//   //     throw Exception('Failed to load album');
//   //   }
//   //
//   //   // var headers = {
//   //   //   'Content-Type': 'application/json'
//   //   // };
//   //   // var request = http.Request('POST', Uri.parse('http://eibtekone-001-site11.atempurl.com/api/GetclincbyId'));
//   //   // request.body = json.encode({
//   //   //   "id":id
//   //   // });
//   //   // request.headers.addAll(headers);
//   //   //
//   //   //
//   //   // http.StreamedResponse response = await request.send();
//   //   //
//   //   // if (response.statusCode == 200) {
//   //   //    print(await response.stream.bytesToString());
//   //   //   Get.to(BookDoctorScreen(id: id, ));
//   //   //   print('id=${id}');
//   //   //
//   //   // }
//   //   // else {
//   //   //   print(response.reasonPhrase);
//   //   // }
//   // }
//   Future categoryId({String? countId}) async {
//     var headers = {
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('GET', Uri.parse('http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${userData.read('id')}'));
//     request.body = json.encode({
//       "count_id": userData.read('CountId')
//     });
//     request.headers.addAll(headers);
//
//     http.StreamedResponse StreamedResponse = await request.send();
//     var response   = await http.Response.fromStream(StreamedResponse);
//     final result = jsonDecode(response .body)  ;
//     if (response.statusCode == 200) {
//       print(result['records'][0]['stor_ImgUrl'] );
//       userData.write('title', result['records'][0]['stor_Title']  );
//       print(userData.read('title'));
//
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//     return result;
//   }
//
//
//   double rating=0;
//   @override
//   Widget build(BuildContext context) {
//     return   FutureBuilder (
//       future: categoryId( ),
//       builder: (context, snapshot){
//
//         if (snapshot.hasData) {
//
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.h),
//             child: SizedBox(
//               height: 400.h,
//               child: ListView.separated(
//                 itemBuilder: (context, index) => Container(
//                   height: 75.h,
//                   width: double.infinity,
//                   padding:
//                   EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.h),
//                   decoration: BoxDecoration(
//                     color: Styles.defaultColor5,
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: InkWell(
//                     onTap: () {
//                       // showDialog(
//                       //   context: context,
//                       //   builder:(context)=>
//                       //       Dialog(
//                       //         shape: RoundedRectangleBorder(
//                       //             borderRadius: BorderRadius.circular(30)),
//                       //
//                       //         child: Container(
//                       //           height: 210,
//                       //           width: 250,
//                       //
//                       //           child: Column(
//                       //             mainAxisAlignment: MainAxisAlignment.center,
//                       //             children: [
//                       //               Text('قم بإضافة رأيك',style: TextStyle(
//                       //                 fontWeight: FontWeight.w500,
//                       //                 fontSize: 17.sp,
//                       //               ),),
//                       //               Text('يرجي تقييم الخدمة وإضافة رأيك في العملية  ',style: TextStyle(
//                       //                 fontWeight: FontWeight.w500,
//                       //                 color: Styles.defualtColor2,
//                       //                 fontSize: 14.sp,
//                       //               ),),
//                       //               Gap(10.h),
//                       //               RatingBar.builder(
//                       //                 initialRating: rating,
//                       //                 minRating: 1,
//                       //                 itemSize: 30,
//                       //                 itemPadding: EdgeInsets.symmetric(horizontal: 2),
//                       //                 itemBuilder: (context,_)=>Icon(
//                       //                   Icons.star,
//                       //                   color: Colors.yellow.shade300,
//                       //                   size: 18.sp,
//                       //                 ),
//                       //                 updateOnDrag: true,
//                       //                 onRatingUpdate: (rating)=>setState(() {
//                       //                   this.rating=rating;
//                       //                 }),
//                       //               ),
//                       //               Gap(20.h),
//                       //               InkWell(
//                       //                 onTap: (){
//                       //                   Get.back();
//                       //                 },
//                       //                 child: Container(
//                       //                   height: 40.h,
//                       //                   width: 100.h,
//                       //                   decoration: BoxDecoration(
//                       //                     borderRadius: BorderRadius.circular(5.h),
//                       //                     color: Styles.defualtColor,
//                       //                   ),
//                       //                 child: Icon(Icons.send,color: Colors.white,),
//                       //                 ),
//                       //               )
//                       //
//                       //             ],
//                       //           ),
//                       //         ),
//                       //
//                       //       ),
//                       //
//                       // );
//                       Get.to(OfferScreen());
//                     },
//                     child: Row(
//                       children: [
//                         Image(
//                             height: 50.h,
//                             width: 50.h,
//                             image: NetworkImage(
//                               'http://eibtekone-001-site18.atempurl.com/${snapshot.data['records'][index]['stor_ImgUrl']}',
//                             )),
//                         Gap(10.h),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   '${snapshot.data['records'][index]['stor_Title']}',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 14.sp
//                                   ),
//                                 ),
//
//                                 // Text(
//                                 //   'vvv',
//                                 //   style: TextStyle(
//                                 //       color: Colors.grey.shade400,
//                                 //       fontSize: 10.sp),
//                                 // ),
//                                 // Gap(5.h),
//                                 // RatingBar.builder(
//                                 //   initialRating: rating,
//                                 //   minRating: 1,
//                                 //   itemSize: 11,
//                                 //   itemPadding:
//                                 //   EdgeInsets.symmetric(horizontal: 1),
//                                 //   itemBuilder: (context, _) => Icon(
//                                 //     Icons.star,
//                                 //     color: Colors.yellow.shade300,
//                                 //     size: 15.sp,
//                                 //   ),
//                                 //   updateOnDrag: true,
//                                 //   onRatingUpdate: (rating)  {},
//                                 // ),
//                               ],
//                             ),
//                             Gap(3.h),
//                             Row(
//                               children: [
//                                 Text(
//                                   LocaleKeys.Store_link.tr(),
//                                   style: TextStyle(
//                                     fontSize: 10.sp,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                 ),
//                                 Gap(5.h),
//                                 Icon(
//                                   Icons.arrow_forward_ios_outlined,
//                                   size: 10.sp,
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 Gap(5.h),
//                                 InkWell(
//                                   onTap: (){_launchUrl('${snapshot.data['records'][index]['stor_Link']}');},
//                                   child: Text(
//                                     '${snapshot.data['records'][index]['stor_Link']}',
//                                     style: TextStyle(
//                                       fontSize: 10.sp,
//                                       color: Colors.grey.shade400,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Gap(3.h),
//                             Text(
//                               '${snapshot.data['records'][index]['stor_Deteils']}',
//                               style: TextStyle(
//                                 fontSize: 8.sp,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 separatorBuilder: (context, index) => Gap(5.h),
//                 itemCount: snapshot.data['records'].length,
//               ),
//             ),
//           );
//         } else {
//           return Center(
//             child:Text('choose Category Above',style: TextStyle(color: Styles.defualtColor,fontSize: 15.sp),),
//           );
//         }
//       },
//     );
//   }
//   Future<void> _launchUrl(String link ) async {
//     if (await launchUrl(Uri.parse(link))) {
//       throw Exception('Could not launch  ');
//     }
//   }
// }
