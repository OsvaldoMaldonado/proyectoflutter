// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'model/modelo_login_cuentas.dart';

// ignore: must_be_immutable
class LoginEmployeeScreen extends StatelessWidget{

  TextEditingController entrada_login_Empleado_NombreCorreo = TextEditingController();
  TextEditingController entrada_login_Empleado_NombreContra = TextEditingController();
  String getvalue = "";
  String getvalue2 = "";

  LoginEmployeeScreen({Key? key}) : super(key: key);
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
                'Iniciar sesi??n',
                  style: TextStyle(
                  fontSize: 22),
                ),
            ),
            SizedBox(height: screenheight * 0.03,),
            SizedBox(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: entrada_login_Empleado_NombreCorreo,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Correo Electronico',
                ),
              ),
            ),
            SizedBox(height: screenheight * 0.01,),
            SizedBox(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                obscureText: true,
                controller: entrada_login_Empleado_NombreContra,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password_outlined),
                  labelText: 'Contrase??a',
                ),
              ),
            ),
            SizedBox(height: screenheight * 0.02),
            OutlinedButton(
              onPressed: () async{
                getvalue = entrada_login_Empleado_NombreContra.text.toString();
                getvalue2 = entrada_login_Empleado_NombreCorreo.text.toString();
                loginempleado(getvalue2, getvalue, context);
              },
              child: const Text('Iniciar sesi??n', style: TextStyle(color: Colors.white, fontSize: 20)),
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
