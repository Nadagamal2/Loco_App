import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
 import 'package:get_storage/get_storage.dart';
 import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loco/screens/sign_up_screen.dart';
import '../translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../component/app_styles.dart';
import '../component/component.dart';
import 'ForgetNumberScreen.dart';
import 'bottom_nav.dart';
import 'login_api.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoggedIn = false;
  Map _userObj = {};
  var formKey = GlobalKey<FormState>();
  final userData =GetStorage();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  //bool? isChecked=false;
  void login(String email,String password, )async{
    try{
      var response = await http.post(
          Uri.parse('http://eibtekone-001-site18.atempurl.com/api/auth/login'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email":email,
            "password":password,
          }
          ));
      var data=jsonDecode(response.body.toString());
      if(response.statusCode==200){

        var log=json.decode(response.body);

        print('token${log['token']}');
        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId=payload['Id'];
        var userName=payload['FullName'];
        var Email=payload['Email'];
        var PhoneNumber=payload['PhoneNumber'];
        var ImgUrl=payload['ImgUrl'];
        print('tokenId ${tokenId}');


        print('read token ${userData.read('token')}');
        print('read userName ${userData.read('userName')}');
        print('read Email ${userData.read('Email')}');
        print('read PhoneNumber ${userData.read('PhoneNumber')}');
        print('read ImgUrl ${userData.read('ImgUrl')}');

        userData.write('isLogged', true);
        userData.write('isLoggedByGoogle', false);
        userData.write('token', payload['Id']);
        userData.write('userName', payload['FullName']);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        userData.write('ImgUrl', payload['ImgUrl']);

        userData.write('email', email);
        userData.write('password', password);
        Get.offAll(BottomNavScreen());


        //  return login.fromJson(jsonDecode(response.body));

      }else{
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,


            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print("Faild");
      }


    }catch(e){
      print(e.toString());
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
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
                children: [



                ],
              ),
            ),
          ),
          Padding(
            padding:   EdgeInsets.symmetric(horizontal: 15.h),
            child: SingleChildScrollView(
              child: Stack(

                children: [
                  Image(image:AssetImage('assets/5.png')),
                  Padding(
                    padding:   EdgeInsets.only(top: 300.h),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            LocaleKeys.LOG_IN.tr(),
                            style: Styles.headLine2,
                          ),

                          Text(
                            LocaleKeys.Log_in_now_and_enjoy_all_the_benefits.tr(),
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return  LocaleKeys.please_enter_your_email.tr();
                              }
                            },

                            controller: emailController,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.h),
                                filled: true,
                                fillColor: Color(0xffF6F5F5),


                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),

                                labelText:     LocaleKeys.Email.tr(),
                                hintText:  LocaleKeys.Email.tr(),
                                labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade400
                                ),

                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade400
                                )

                            ),
                          ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.end,
                          //       children: [
                          //         Text( 'البريد الإلكتروني',style: TextStyle(
                          //           fontSize: 15.sp,
                          //         ),)
                          //       ],
                          //     ),
                          //     Gap(5.h),
                          //     TextFormField(
                          //
                          //
                          //       cursorColor: Colors.grey.shade400,
                          //       keyboardType: TextInputType.emailAddress,
                          //       validator: (String? val) {
                          //         if (val!.isEmpty) {
                          //           return 'please enter your name';
                          //         }
                          //       },
                          //
                          //       controller: emailController,
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
                          //           labelText:    'البريد الإلكتروني',
                          //           hintText:  'البريد الإلكتروني',
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
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Gap(15.h),
                          TextFormField(


                            cursorColor: Colors.grey.shade400,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return LocaleKeys.please_enter_your_password.tr();
                              }
                            },
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.h),
                                filled: true,
                                fillColor: Color(0xffF6F5F5),


                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: .1.r,color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),

                                labelText:   LocaleKeys.Password_.tr(),
                                hintText:   LocaleKeys.Password_.tr(),
                                labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade400
                                ),

                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade400
                                )

                            ),
                          ),


                          Padding(
                            padding:   EdgeInsets.symmetric(horizontal: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ForgetNumberScreen()));
                                    },
                                    child: Text(
                                      LocaleKeys.Forget_Password.tr(),
                                      style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,

                                    ),
                                    )),
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
                              LocaleKeys.Login.tr(),
                              style: TextStyle(
                                color: Styles.defaultColor5,
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              if (formKey.currentState!.validate()

                              ) {
                                login(emailController.text.toString(), passwordController.text.toString());
                              }
                            },

                          ),
                          Gap(8.h),
                          Row(   mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.Login_via.tr(),
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Gap(11.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // InkWell(
                                  //   onTap:(){
                                  //
                                  //   },
                                  //   child: Container(
                                  //     height: 30.h,
                                  //     width: 30.h,
                                  //     decoration: BoxDecoration(
                                  //         color: Styles.defaultColor5,
                                  //
                                  //         shape: BoxShape.circle,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             color: Colors.grey.shade300,
                                  //             spreadRadius: 1,
                                  //             blurRadius: 2,
                                  //             offset: Offset(1,2),
                                  //           )
                                  //         ]
                                  //     ),
                                  //     child: Stack(alignment: Alignment.center,
                                  //       children: [
                                  //         Container(
                                  //
                                  //
                                  //
                                  //           height: 15.h,
                                  //           width: 15.h,
                                  //           decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(2.r),
                                  //               image: DecorationImage(
                                  //                 fit: BoxFit.cover,
                                  //                 image: AssetImage('assets/ff.png'),
                                  //               )
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // Gap(20.h),
                                  InkWell(
                                    onTap:()async{
                                      var user=await LoginApi.login();
                                      userData.write('isLoggedByGoogle', true);
                                      userData.write('isLogged', false);

                                      if(user!=null){
                                        print('Done');
                                        userData.write('name', user.displayName);
                                        userData.write('img', user.photoUrl);
                                        userData.write('email', user.email);
                                        print(user.displayName);
                                        print(user.email);
                                        print(userData.read('name'));
                                        print(userData.read('email'));
                                       Get.offAll(BottomNavScreen());


                                      }
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 30.h,
                                      decoration: BoxDecoration(
                                          color: Styles.defaultColor5,

                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(1,2),
                                            )
                                          ]
                                      ),
                                      child: Stack(alignment: Alignment.center,
                                        children: [
                                          Container(



                                            height: 15.h,
                                            width: 15.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(2.r),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage('assets/gg.png'),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(LocaleKeys.Dont_have_an_account.tr(), style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,

                              ),),
                              TextButton( onPressed: () {Get.to(SignupScreen());  }, child: Text(
                                LocaleKeys.Create_an_account.tr(),
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


                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
