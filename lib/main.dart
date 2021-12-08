import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/screens_client/navigation_home_screen.dart';
import 'package:servicios_vic/screens_employee/navigation_home_employee_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:  Colors.transparent,
      systemNavigationBarDividerColor: Colors.black, // navigation bar color
      statusBarColor: Colors.white.withOpacity(0.0), // status bar color
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
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
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        platform: TargetPlatform.android,
      ),
      home: id == null ? const HomeScreen() : type == 'usuario' ? 
      const NavigationHomeScreen() : const NavigationHomeEmployeeScreen()
    );
  }
}