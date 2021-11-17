import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/navigation_home_employee_screen.dart';
import 'package:servicios_vic/navigation_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';


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
    String? id = prefs.getString('id');
    String? type = prefs.getString('type');
    
    runApp(MyApp(id: id, type: type));
  // ignore: prefer_const_constructors    
}

class MyApp extends StatelessWidget {

  final String? id;
  final String? type;

  const MyApp({Key? key, this.id, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiciosVic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        platform: TargetPlatform.android,
      ),
      home: id == null ? const HomeScreen() : type == 'usuario' ? 
      const NavigationHomeScreen() : const NavigationHomeEmployeeScreen()
    );
  }
}