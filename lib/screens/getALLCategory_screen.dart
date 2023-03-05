// import 'dart:convert';
//
// import 'package:copon/screens/offer_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
//
// import '../component/app_styles.dart';
// import '../models/categoryID.dart';
// import '../models/getAllCategory_model.dart';
// class GetAllCategoryScreen extends StatefulWidget {
//   const GetAllCategoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<GetAllCategoryScreen> createState() => _GetAllCategoryScreenState();
// }
//
// class _GetAllCategoryScreenState extends State<GetAllCategoryScreen> {
//   final userData =GetStorage();
//   Future<CategoryAllModel> categoryAll({int? id}) async {
//     final response = await http.get(Uri.parse(
//         'http://eibtekone-001-site18.atempurl.com/api/GetAllStores/lll'));
//
//     var data = jsonDecode(response.body.toString());
//
//     if (response.statusCode == 200) {
//       print(response.body.length);
//
//       print(data);
//       return CategoryAllModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load album');
//     }
//
//
//   }
//   double rating=0;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: categoryAll(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
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
//                               'http://eibtekone-001-site18.atempurl.com/${snapshot.data!.records[index].storImgUrl}',
//                             )),
//                         Gap(10.h),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   '${snapshot.data!.records[index].storTitle}',
//                                   style: TextStyle(),
//                                 ),
//                                 Gap(5.h),
//                                 Text(
//                                   '${rating}',
//                                   style: TextStyle(
//                                       color: Colors.grey.shade400,
//                                       fontSize: 10.sp),
//                                 ),
//                                 Gap(5.h),
//                                 RatingBar.builder(
//                                   initialRating: rating,
//                                   minRating: 1,
//                                   itemSize: 11,
//                                   itemPadding:
//                                   EdgeInsets.symmetric(horizontal: 1),
//                                   itemBuilder: (context, _) => Icon(
//                                     Icons.star,
//                                     color: Colors.yellow.shade300,
//                                     size: 15.sp,
//                                   ),
//                                   updateOnDrag: true,
//                                   onRatingUpdate: (rating) => setState(() {
//                                     this.rating = rating;
//                                   }),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   'المتاجر',
//                                   style: TextStyle(
//                                     fontSize: 10.sp,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                 ),
//                                 Gap(5.h),
//                                 Icon(
//                                   Icons.arrow_back_ios_new_outlined,
//                                   size: 10.sp,
//                                   color: Colors.grey.shade400,
//                                 ),
//                                 Gap(5.h),
//                                 Text(
//                                   'قسم السوبر ماركت',
//                                   style: TextStyle(
//                                     fontSize: 10.sp,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               'رقم 254 شارع هشام بن عبد الملك-الباديه-حائل 21231 السعوديه',
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
//                 itemCount: snapshot.data!.records.length,
//               ),
//             ),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
