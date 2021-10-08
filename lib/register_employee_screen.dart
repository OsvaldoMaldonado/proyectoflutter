// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'model/modelo.dart';
import 'register_employee_jobs_screen.dart';
class RegisterEmployeeScreen extends StatelessWidget{
  TextEditingController entrada_registro_Empleado_NombreCorreo = TextEditingController();
  TextEditingController entrada_registro_Empleado_NombreCuenta = TextEditingController();
  TextEditingController entrada_registro_Empleado_ApellidoCuenta = TextEditingController();
  TextEditingController entrada_registro_Empleado_ContraCuenta = TextEditingController();
  TextEditingController entrada_registro_Empleado_RFCCuenta = TextEditingController();
  String getvalue = "";
  String getvalue2 = "";
  String getvalue3 = "";
  String getvalue4 = "";
  String getvalue5 = "";

  RegisterEmployeeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
     body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: screenSize,
                  height: screenheight * 0.10,
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
               decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child:const Text(
                    'Crear Cuenta',
                    style: TextStyle(
                    fontSize: 22),
                  ),
                ),
                SizedBox(height: screenheight * 0.04,),
                SizedBox(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,
                  child:TextField(
                    controller: entrada_registro_Empleado_NombreCorreo,
                    decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                      hintText: 'Correo Electronico',
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: screenSize * 0.05),
                    SizedBox(
                      width: screenSize * 0.40,
                      height: screenheight * 0.10,

                      child:TextField(
                        controller: entrada_registro_Empleado_NombreCuenta,
                         decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Nombre',
                        ),
                      ),
                    ),
                    SizedBox(width: screenSize * 0.05),
                    SizedBox(
                      width: screenSize * 0.45,
                      height: screenheight * 0.10,
                      child:TextField(
                        controller: entrada_registro_Empleado_ApellidoCuenta,
                         decoration: const InputDecoration(
                          labelText: 'Apellido',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,
                  child:TextField(
                    controller: entrada_registro_Empleado_ContraCuenta,
                    obscureText: true,
                     decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,
                  child:const TextField(
                    obscureText: true,
                     decoration: InputDecoration(
                          icon: Icon(Icons.verified_sharp),
                      labelText: 'Vuelva a escribir la contraseña',
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,
                  child:TextField(
                    controller: entrada_registro_Empleado_RFCCuenta,
                     decoration: const InputDecoration(
                          icon: Icon(Icons.format_align_center),
                      labelText: 'RFC',
                    ),
                  ),
                ),
                OutlinedButton(

                  onPressed: () {
                    getvalue = entrada_registro_Empleado_NombreCuenta.text.toString();
                    getvalue2 = entrada_registro_Empleado_ApellidoCuenta.text.toString();
                    getvalue3 = entrada_registro_Empleado_ContraCuenta.text.toString();
                    getvalue4 = entrada_registro_Empleado_RFCCuenta.text.toString();
                    getvalue5 = entrada_registro_Empleado_NombreCorreo.text.toString();
                    insertarempleado(getvalue5, getvalue, getvalue2, getvalue3, getvalue4);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterEmployeeJobsScreen()));

                  },
                  child: const Text('Siguiente', style: TextStyle(color: Colors.white, fontSize: 20)),
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
