// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'model/modelo_login_cuentas.dart';

// ignore: must_be_immutable
class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({Key? key}) : super(key: key);

  @override
  LoginUserState createState() => LoginUserState();
}

// ignore: must_be_immutable
class LoginUserState extends State<LoginUserScreen>{

  TextEditingController entrada_login_NombreCorreo = TextEditingController();
  TextEditingController entrada_login_NombreContra = TextEditingController();
  String getvalue = "";
  String getvalue2 = "";

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                  height: screenHeight * 0.22,
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
                    height: screenHeight * 0.03,
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
                'Iniciar sesión',
                style: TextStyle(
                fontSize: 22),
              ),
            ),
            SizedBox(height: screenHeight * 0.05,),
            SizedBox(
              width: screenSize * 0.90,
              height: screenHeight * 0.10,
              child:TextField(
                controller: entrada_login_NombreCorreo,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Correo Electronico',
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            SizedBox(
              width: screenSize * 0.90,
              height: screenHeight * 0.10,
              child:TextField(
                controller: entrada_login_NombreContra,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password_outlined),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03,),
            OutlinedButton(
              onPressed: () async{
                getvalue = entrada_login_NombreContra.text.toString();
                getvalue2 = entrada_login_NombreCorreo.text.toString();
                userLogin(getvalue2, getvalue, context);
              },
              child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white, fontSize: 20)),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder (
                  side: BorderSide( width: 20,)
                ),
                side: const BorderSide( width: 1, color: Color(0xFFF96332),),
                    //  padding: EdgeInsets.all(60),
                minimumSize: Size(screenSize * 0.90, screenHeight * 0.07),
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
