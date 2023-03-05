


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loco/screens/onBoarding_screen.dart';
import 'package:loco/translations/codegen_loader.g.dart';

import 'component/app_styles.dart';
import 'screens/bottom_nav.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:  Brightness.dark,
  ));
  await GetStorage.init();

  runApp(EasyLocalization(
      child:    MyApp(),
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      assetLoader: CodegenLoader(),
      saveLocale: true,
      path: "assets/translations"));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

}

class _MyAppState extends State<MyApp> {
  final userData =GetStorage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'LOCO',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          scaffoldBackgroundColor:Color(0xffF7F7F7),
        ),
        home: child,
      ),
      child:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userData = GetStorage();

  @override
  void initState() {
    super.initState();
    userData.writeIfNull('isLogged', false);
    userData.writeIfNull('isLoggedByGoogle', false);
    Future.delayed(Duration.zero, () async {
      checkIfLoged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
            ),
          ),
        ));
  }

  void checkIfLoged() {
    userData.read('isLogged')||userData.read('isLoggedByGoogle')
        ? Get.offAll(BottomNavScreen())
        : Get.offAll(OnBoardingScreen());
  }
}