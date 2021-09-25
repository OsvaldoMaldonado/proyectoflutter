import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicios_vic/navigation_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: const Color(0xfff96332), // status bar color
  ));
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
    return MaterialApp(
      
      title: 'Servicios Vic',
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        platform: TargetPlatform.android,
      ),
      home: NavigationHomeScreen(),
    );
  }
}
