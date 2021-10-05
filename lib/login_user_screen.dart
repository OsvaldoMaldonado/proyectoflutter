// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:servicios_vic/navigation_home_screen.dart';
import 'model/modelo.dart';

// ignore: must_be_immutable
class LoginUserScreen extends StatelessWidget{

  TextEditingController entrada_login_NombreCorreo = TextEditingController();
  TextEditingController entrada_login_NombreContra = TextEditingController();
  String getvalue = "";
  String getvalue2 = "";

  LoginUserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    Future<String?> id_Usuario;
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
                'Iniciar sesión',
                style: TextStyle(
                fontSize: 22),
              ),
            ),
            SizedBox(height: screenheight * 0.05,),
            SizedBox(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: entrada_login_NombreCorreo,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Correo Electronico',
                ),
              ),
            ),
            SizedBox(
              width: screenSize * 0.90,
              height: screenheight * 0.10,
              child:TextField(
                controller: entrada_login_NombreContra,
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password_outlined),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            SizedBox(height: screenheight * 0.03,),
            OutlinedButton(
              onPressed: () async{
                getvalue = entrada_login_NombreContra.text.toString();
                getvalue2 = entrada_login_NombreCorreo.text.toString();
                id_Usuario = login(getvalue2, getvalue);
                if(id_Usuario!=null){
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationHomeScreen(id_usuario: id_Usuario,)),
                   );
                }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Credenciales Incorrectas"),
                  ));
                }
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
