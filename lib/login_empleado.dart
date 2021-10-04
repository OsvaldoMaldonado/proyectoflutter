import 'package:flutter/material.dart';
import 'modelo.dart';

class login_empleado extends StatelessWidget{

  TextEditingController entrada_login_Empleado_NombreCorreo = TextEditingController();
  TextEditingController entrada_login_Empleado_NombreContra = TextEditingController();
  String getvalue = "";
  String getvalue2 = "";
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
               RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: SizedBox(
                    width: screenSize,
                    height: screenheight * 0.22,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFF6365),
                            Color(0xFFF96332),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom : 0,
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(180 / 360),
                    child: Container(
                      width: screenSize,
                      height: screenheight * 0.02,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
            Container(

              alignment: Alignment.centerLeft,
              child:const Text(
                '  Iniciar sesión',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 25),
                ),
            ),
            SizedBox(height: screenheight * 0.03,),
            Container(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: entrada_login_Empleado_NombreCorreo,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                  fillColor: Color(0xFFe0e0e0), filled: true,
                  labelText: 'Correo Electronico',
                ),
              ),
            ),
            Container(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: entrada_login_Empleado_NombreContra,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                  fillColor: Color(0xFFe0e0e0), filled: true,
                  labelText: 'Contraseña',
                ),
              ),
            ),
            OutlinedButton(

              onPressed: () async{
                getvalue = entrada_login_Empleado_NombreContra.text.toString();
                getvalue2 = entrada_login_Empleado_NombreCorreo.text.toString();
                loginempleado(getvalue2, getvalue);
              },
              child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white, fontSize: 20)),
                style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder (
                      side: BorderSide(
                          width: 20,
                      )
                    ),
                  side: const BorderSide( width: 1, color: Color(0xFFF96332),),
                    //  padding: EdgeInsets.all(60),
                  minimumSize: Size(screenSize * 0.90, screenheight * 0.07),
                    backgroundColor: const Color(0xFFF96332),
                ),
              ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      // onPressed: _incrementCounter,
      // tooltip: 'Increment',
      // child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
