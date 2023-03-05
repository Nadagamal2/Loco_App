import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
 import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../component/app_styles.dart';
import '../component/component.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'doneScreen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final userData = GetStorage();

  final userNameController = new TextEditingController();
  final PhoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  void editProfile(
    String FullName,
    String PhoneNumber,
    String email,
    String img,
  ) async {
    var headers = {
      'Content-Encoding': 'application/ecmascript',
      'Accept': 'image/jpeg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://eibtekone-001-site18.atempurl.com/api/auth/EditeAccount/${userData.read('token')}'));
    request.fields
        .addAll({'Email': email, 'Name': FullName, 'Phone': PhoneNumber});


    request.files.add(await http.MultipartFile.fromPath('Photo', img));
    request.headers.addAll(headers);

    var streamedResponse  = await request.send();
    var response   = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response .body) as Map<String, dynamic>;
    print(result['isSuccess']);
    if (result['isSuccess']==true) {


      print(result['token']);
      Map<String, dynamic> payload = Jwt.parseJwt(result['token']);
      var  tokenId=payload['Id'];
      var userName=payload['FullName'];
      var Email=payload['Email'];
      var PhoneNumber=payload['PhoneNumber'];
      var ImgUrl=payload['ImgUrl'];
      print('ImgUrl= ${ImgUrl}');
      userData.write('tokenEdit', payload['Id']);

      userData.write('EmailEdit', payload['Email']);
      userData.write('PhoneNumberEdit', payload['PhoneNumber']);
      userData.write('ImgUrlEdit', ImgUrl);
      Get.offAll(DoneScreen());
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
          msg: '${response.reasonPhrase}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Styles.defualtColor,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
  var formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    PhoneNumberController.dispose();
    userNameController.dispose();
    emailController.dispose();

    super.dispose();
  }

  static File? file;
  String? imag;
  ImagePicker image = ImagePicker();
  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      print(img.path);

      imag = img.path;
      userData.write('path', file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(70.h),
              Text(
                LocaleKeys.Modify_your_Account.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(30.h),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  file == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage('assets/2345.png'),
                          radius: 45.r,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(file!),
                          radius: 45.r,
                        ),
                  InkWell(
                    onTap: () {
                      getGallery();
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xff898A8F),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Styles.ScafoldColor,
                        size: 14.sp,
                      ),
                      radius: 13.r,
                    ),
                  )
                ],
              ),
              Gap(30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.text,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return LocaleKeys.Please_Enter_Your_Updated_Name.tr();
                          }
                        },
                        controller: userNameController,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
                            filled: true,
                            fillColor: Color(0xffF6F5F5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            labelText: LocaleKeys.new_user_name.tr(),
                            hintText: LocaleKeys.new_user_name.tr(),
                            labelStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400)),
                      ),
                      Gap(15.h),
                      TextFormField(
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.number,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return LocaleKeys.Please_Enter_Your_Updated_Number.tr();
                          }
                        },
                        controller: PhoneNumberController,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
                            filled: true,
                            fillColor: Color(0xffF6F5F5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            labelText: LocaleKeys.new_phone_number.tr(),
                            hintText:LocaleKeys.new_phone_number.tr(),
                            labelStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400)),
                      ),
                      Gap(15.h),
                      TextFormField(
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return LocaleKeys.Please_Enter_Your_Updated_Email.tr();
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
                            filled: true,
                            fillColor: Color(0xffF6F5F5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            labelText: LocaleKeys.new_email.tr(),
                            hintText: LocaleKeys.new_email.tr(),
                            labelStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 15.sp, color: Colors.grey.shade400)),
                      ),
                      Gap(80.h),
                      buildBottum(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: double.infinity,
                        text: Text(
                          LocaleKeys.Change.tr(),
                          style: TextStyle(
                              color: Styles.defaultColor5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()

                          ){editProfile(
                              userNameController.text.toString(),
                              PhoneNumberController.text.toString(),
                              emailController.text.toString(),
                              imag!);}


                        },
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20.h),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text( LocaleKeys.Back.tr(),
                      style: TextStyle(color: Colors.grey, fontSize: 16.sp))),
            ],
          ),
        ),
      ),
    );
  }
}
