import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/navigation_home_employee_screen.dart';
import 'package:servicios_vic/navigation_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor:  Colors.transparent,
      systemNavigationBarDividerColor: Colors.black, // navigation bar color
      statusBarColor: Color(0xfff96332), // status bar color
     ));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var type = prefs.getString('type');
    runApp(MaterialApp(
      title: 'ServiciosVic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        platform: TargetPlatform.android,
      ),
      home: id == null ? const HomeScreen() : type == 'usuario' ? 
      const NavigationHomeScreen() : const NavigationHomeEmployeeScreen())
    );
  // ignore: prefer_const_constructors
    
}