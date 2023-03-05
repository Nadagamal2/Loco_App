import 'dart:convert';
import 'package:loco/screens/bottom_nav.dart';
import 'package:loco/screens/signIn_screen.dart';

import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
 import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
 import 'package:http/http.dart' as http;

import '../component/app_styles.dart';
import '../component/component.dart';
 import 'map_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  final userNameController = new TextEditingController();
  final PhoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();
  bool? isChecked = false;
  final userData = GetStorage();

  void re(
    String FullName,
    PhoneNumber,
    email,
    password,
    confirmPassword,
  ) async {
   try{
     var response = await http.post(
         Uri.parse('http://eibtekone-001-site18.atempurl.com/api/auth/Register/1'),
         headers: {
           "Content-Type": "application/json",
         },
         body: jsonEncode({
           "FullName": FullName,
           "PhoneNumber": PhoneNumber,
           "email": email,
           "password": password,
           "confirmPassword": confirmPassword
         }
         ));
     var data=jsonDecode(response.body.toString());
     if (response.statusCode == 200) {

       print(await response.body);
       var log=json.decode(response.body);
       print('token${log['token']}');
       Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
       var tokenId=payload['Id'];
       var Email=payload['Email'];
       var PhoneNumbe =payload['PhoneNumbe'];
       var CountId =payload['CountId'];
       print('tokenId ${tokenId}');
       print('read token ${userData.read('token')}');
       print('read token ${userData.read('CountId')}');

       userData.write('isLogged', true);
       userData.write('Email', payload['Email']);
       userData.write('PhoneNumbe', payload['PhoneNumber']);
       userData.write('FullName', payload['FullName']);
       userData.write('CountId', payload['CountId']);
       userData.write('token', payload['Id']);
       // userData.write('email', email);
       // userData.write('password', password);
       // userData.write('confirmPassword', confirmPassword);

       Get.offAll(BottomNavScreen());
     } else {
       Fluttertoast.showToast(
           msg: '${data['errors']}',
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.BOTTOM,


           timeInSecForIosWeb: 1,
           textColor: Colors.white,
           fontSize: 16.0
       );
       print(await response.body);
       print(response.reasonPhrase);

     }
   }catch(e){print(e);}
  }
  // void re(
  //   String FullName,
  //   PhoneNumber,
  //   email,
  //   password,
  //   confirmPassword,
  // ) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           'http://eibtekone-001-site18.atempurl.com/api/auth/Register'));
  //   request.body = json.encode({
  //     "FullName": FullName,
  //     "PhoneNumber": PhoneNumber,
  //     "email": email,
  //     "password": password,
  //     "confirmPassword": confirmPassword
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   var data=jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //
  //     print(await response.stream.bytesToString());
  //
  //     userData.write('isLogged', true);
  //     userData.write('FullName', FullName);
  //     userData.write('PhoneNumber', PhoneNumber);
  //     userData.write('email', email);
  //     userData.write('password', password);
  //     userData.write('confirmPassword', confirmPassword);
  //
  //     Get.offAll(BottomNavScreen());
  //   } else {
  //     print(await response.stream.bytesToString());
  //     print(response.reasonPhrase);
  //     Fluttertoast.showToast(
  //         msg: '${data['message']}',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Styles.defualtColor,
  //
  //         timeInSecForIosWeb: 1,
  //         textColor: Colors.black,
  //         fontSize: 16.0
  //     );
  //   }
  // }

  @override
  void dispose() {
    PhoneNumberController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: 690.h,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Image(image: AssetImage('assets/44.png')),
                  ),
                  Text(
                    LocaleKeys.Create_an_account.tr(),
                    style: Styles.headLine2,
                  ),

                  Text(
                    LocaleKeys.Join_Us_Now.tr(),
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.text,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.please_enter_your_name.tr();
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
                        labelText: LocaleKeys.User_Name.tr(),
                        hintText: LocaleKeys.User_Name.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         Text("إسم المستخدم",style: TextStyle(
                  //           fontSize: 15.sp,
                  //         ),)
                  //       ],
                  //     ),
                  //     Gap(5.h),
                  //     TextFormField(
                  //
                  //
                  //       cursorColor: Colors.grey.shade400,
                  //       keyboardType: TextInputType.text,
                  //       controller: userNameController,
                  //       decoration: InputDecoration(
                  //           floatingLabelBehavior: FloatingLabelBehavior.never,
                  //           contentPadding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.h),
                  //           filled: true,
                  //           fillColor: Color(0xffF6F5F5),
                  //
                  //
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           border: OutlineInputBorder(),
                  //
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                  //             borderRadius: BorderRadius.circular(10.r),
                  //           ),
                  //
                  //           labelText:    'إسم المستخدم',
                  //           hintText:  'إسم المستخدم',
                  //           labelStyle: TextStyle(
                  //               fontSize: 15.sp,
                  //               color: Colors.grey.shade400
                  //           ),
                  //
                  //           hintStyle: TextStyle(
                  //               fontSize: 15.sp,
                  //               color: Colors.grey.shade400
                  //           )
                  //
                  //
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.number,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.please_enter_your_number.tr();
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
                        labelText: LocaleKeys.phone_Number.tr(),
                        hintText: LocaleKeys.phone_Number.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       children: [
                  //         Text("رقم الهاتف",style: TextStyle(
                  //           fontSize: 15.sp,
                  //         ),)
                  //       ],
                  //     ),
                  //     Gap(5.h),
                  //     TextFormField(
                  //
                  //
                  //       cursorColor: Colors.grey.shade400,
                  //       keyboardType: TextInputType.number,
                  //       controller: PhoneNumberController,
                  //       decoration: InputDecoration(
                  //           floatingLabelBehavior: FloatingLabelBehavior.never,
                  //           contentPadding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.h),
                  //           filled: true,
                  //           fillColor: Color(0xffF6F5F5),
                  //
                  //
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           border: OutlineInputBorder(),
                  //
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                  //             borderRadius: BorderRadius.circular(10.r),
                  //           ),
                  //
                  //           labelText:    'رقم الهاتف',
                  //           hintText:  'رقم الهاتف',
                  //           labelStyle: TextStyle(
                  //               fontSize: 15.sp,
                  //               color: Colors.grey.shade400
                  //           ),
                  //
                  //           hintStyle: TextStyle(
                  //               fontSize: 15.sp,
                  //               color: Colors.grey.shade400
                  //           )
                  //
                  //
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.please_enter_your_email.tr();
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
                        labelText: LocaleKeys.Email.tr(),
                        hintText: LocaleKeys.Email.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.text,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.please_enter_your_password.tr();
                      }
                    },
                    controller: passwordController,
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
                        labelText: LocaleKeys.Password_.tr(),
                        hintText: LocaleKeys.Password_.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.text,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return LocaleKeys.please_enter_your_password_again.tr();
                      }
                    },
                    controller: confirmPasswordController,
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
                        labelText: LocaleKeys.Confirm_Password.tr(),
                        hintText: LocaleKeys.Confirm_Password.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  Gap(15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.h),
                    child: Row(
                      children: [
                        RoundCheckBox(
                          size: 15.h,
                          checkedWidget: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 13.sp,
                          ),
                          checkedColor: Styles.defualtColor,
                          onTap: (selected) {
                            isChecked = selected;
                            userData.write('select', selected);
                            print(selected);
                          },
                        ),
                        Gap(5.h),
                        Text(
                          LocaleKeys.Accept_all_permissions.tr(),
                          style: TextStyle(
                              fontSize: 10.sp, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Gap(15.h),
                  buildBottum(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Styles.defualtColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    text: Text(
                      LocaleKeys.sign_Up.tr(),
                      style: TextStyle(
                        color: Styles.defaultColor5,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate() &&
                          passwordController.text == confirmPasswordController.text&&userData.read('select')==true
                          ) {
                        re(
                            userNameController.text.toString(),
                            PhoneNumberController.text.toString(),
                            emailController.text.toString(),
                            passwordController.text.toString(),
                            confirmPasswordController.text.toString());
                      }
                     },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.Already_Have_An_Account.tr(), style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,

                      ),),
                      TextButton( onPressed: () {Get.to(SignInScreen());  }, child: Text(
                        LocaleKeys.LOG_IN.tr(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,

                          color: Colors.black54,

                        ),),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
