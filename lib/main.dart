import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicios_vic/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor:  Colors.transparent,
    systemNavigationBarDividerColor: Colors.black, // navigation bar color
    statusBarColor: const Color(0xfff96332), // status bar color
  ));
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
    return MaterialApp(
      
      title: 'ServiciosVic',
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        platform: TargetPlatform.android,
      ),
      home: HomeScreen(),
    );
  }
}