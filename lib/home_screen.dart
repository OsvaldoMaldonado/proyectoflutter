import 'package:flutter/material.dart';
import 'login_user_screen.dart';
import 'login_employee_screen.dart';
import 'register_user_screen.dart';
import 'register_employee_screen.dart';


class HomeScreen extends  StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: screenSize,
                  height: screenheight * 0.22,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF96332),
                          Color(0xFFFF6365),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom : 0,
                  child: SizedBox(
                    width: screenSize,
                    height: screenheight * 0.03,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child:const Text(
                "¡Bienvenido a Servicios Vic!",
                style: TextStyle(
                fontSize: 22,),
              ),
            ),
            SizedBox(height: screenheight * 0.04,),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUserScreen()));
              },
              child: const Text('Crear Cuenta', style: TextStyle(color: Colors.black, fontSize: 20)
              ),
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder (
                    side: BorderSide(
                        width: 20,
                    )
                  ),
                side: const BorderSide( width: 1, color: Color(0xffe0e0e0),),
                  //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                  backgroundColor: const Color(0xffe0e0e0),
              ),
            ),
            SizedBox(height: screenheight * 0.01,),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUserScreen()));
              },
              child: const Text('Iniciar sesion', style: TextStyle(color: Colors.black, fontSize: 20)
              ),
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder (
                    side: BorderSide(
                        width: 20,
                    )
                  ),
                side: const BorderSide( width: 1, color: Color(0xffe0e0e0),),
                  //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                  backgroundColor: const Color(0xffe0e0e0),
              ),
            ),
            SizedBox(height: screenheight * 0.01,),
            OutlinedButton(
              onPressed: () {

              },
              child: const Text('Continuar como invitado', style: TextStyle(color: Colors.black, fontSize: 20)
              ),
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder (
                    side: BorderSide(
                        width: 20,
                    )
                  ),
                side: const BorderSide( width: 1, color: Color(0xffe0e0e0),),
                  //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                  backgroundColor: const Color(0xffe0e0e0),
              ),
            ),
            SizedBox(height:screenheight * 0.04,),
            const Divider(
              color: Color(0xFFF96332),
              thickness: 2.0,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height:screenheight * 0.04,),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterEmployeeScreen()));
              },
              child: const Text('¡Afiliate con nosotros!', style: TextStyle(color: Color(0xFFF96332), fontSize: 20)
              ),
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder (
                    side: BorderSide(
                        width: 20,
                    )
                  ),
                side: const BorderSide( width: 1, color: Color(0xffe0e0e0),),
                  //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                  backgroundColor: const Color(0xffe0e0e0),
              ),
            ),
            
            SizedBox(height:screenheight * 0.01,),
            OutlinedButton(

              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginEmployeeScreen()));

              },
              child: const Text('Iniciar sesion como prestador', style: TextStyle(color: Color(0xFFF96332), fontSize: 20)
              ),
              style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder (
                    side: BorderSide(
                        width: 20,
                    )
                  ),
                side: const BorderSide( width: 1, color: Color(0xffe0e0e0),),
                  //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                  backgroundColor: const Color(0xffe0e0e0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
