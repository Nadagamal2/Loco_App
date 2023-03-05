import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:gap/gap.dart';
 import 'package:http/http.dart' as http;

import '../component/app_styles.dart';
import '../component/component.dart';
import '../models/question_model.dart';
import '../translations/locale_keys.g.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  Future<QuestionModel> getData() async {
    final response = await http.get(
        Uri.parse('http://eibtekone-001-site18.atempurl.com/api/GetAll_Questions'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode==200) {

      print(response.body);
      return QuestionModel.fromJson(jsonDecode(response.body));
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
          LocaleKeys.About_the_app.tr(),
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
      ),
      // appBar: AppBar(
      //   toolbarHeight: 65.h,
      //   elevation: 0,
      //   backgroundColor: Styles.defualtColor,
      //   // leading: InkWell(
      //   //   child: Container(
      //   //     padding: EdgeInsets.all(10),
      //   //     child: Image(
      //   //       image: AssetImage(
      //   //         'assets/whats.png',
      //   //       ),
      //   //
      //   //
      //   //     ),
      //   //   ),
      //   // ),
      //   centerTitle: true,
      //   title:  Text(
      //      'questions',
      //     style: TextStyle(
      //       fontSize: 15.sp,
      //     ),
      //   ),
      //
      // ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [



          Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder(
              future: getData(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return SizedBox(
                    height: 500.h,
                    child: ListView.separated(
                      itemBuilder: (context,index)=> Column(
                        children: [
                          BuildQuestionScreen(text1:   '${snapshot.data!.records![index].question}', text2:  '${snapshot.data!.records![index].answer}',),







                        ],
                      ),
                      separatorBuilder: (context,index)=>Gap(5.h),
                      itemCount: snapshot.data!.records!.length,
                    ),
                  );
                }else {
                  return Center(
                    child: CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(Styles.defualtColor),),
                  );
                }
              },

            ),
          )
        ],),
    );
  }
}
