
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revue_mobile/MainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';



Future<void> main() async {

  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.setBool("login",false);
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //   runApp(new MyApp());
  // });


  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool status = prefs.getBool('isLoggedIn') ?null:false;
  String email = prefs.getString("email");

  print(email);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: CupertinoColors.extraLightBackgroundGray,
    statusBarIconBrightness:  Brightness.dark,

  ),);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
      CupertinoApp(
    debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        theme: CupertinoThemeData(

          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
            primaryColor: CupertinoColors.black,
            textTheme: CupertinoTextThemeData
              (textStyle: TextStyle(fontFamily: GoogleFonts.mulish().fontFamily))
        ),
    home: email == null ? Login() : MainScreen(),
  )
  // MyApp(status)
  );
}

class MyApp extends StatelessWidget {
   // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: CupertinoColors.extraLightBackgroundGray,
      statusBarIconBrightness:  Brightness.dark,

    ),);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    return CupertinoApp(
      title: 'Flutter Demo',
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
      theme: CupertinoThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primaryColor: CupertinoColors.black
      ),
      // home:loginStatus==false?Login(): MainScreen()
    );
  }
}





