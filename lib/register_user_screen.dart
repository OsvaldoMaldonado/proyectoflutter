// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:servicios_vic/login_user_screen.dart';
import 'model/modelo.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  RegisterUserState createState() => RegisterUserState();
}
class RegisterUserState extends State<RegisterUserScreen> {

  TextEditingController entrada_registro_NombreCorreo = TextEditingController();
  TextEditingController entrada_registro_NombreCuenta = TextEditingController();
  TextEditingController entrada_registro_ApellidoCuenta = TextEditingController();
  TextEditingController entrada_registro_ContraCuenta = TextEditingController();
  TextEditingController entrada_registro_TelefonoCuenta = TextEditingController();
  String getvalue = "";
  String getvalue2 = "";
  String getvalue3 = "";
  String getvalue4 = "";
  String getvalue5 = "";
  String dropdownValue = 'Efectivo';
  var visibilidad1 = false;
  var visibilidad2 = false;
  var visibilidad3 = false;
  var visibilidad4 = false;
  var visibilidad5 = false;

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

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
                  SizedBox(height: screenheight * 0.03,),
                  SizedBox(
                      width: screenSize * 0.90,
                      height: screenheight * 0.10,
                      child:TextField(
                        controller: entrada_registro_NombreCorreo,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Correo Electronico',
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
                          controller: entrada_registro_NombreCuenta,
                          decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                            labelText: 'Nombre',
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize * 0.05,),
                      SizedBox(
                        width: screenSize * 0.45,
                        height: screenheight * 0.10,
                        child:TextField(
                          controller: entrada_registro_ApellidoCuenta,
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
                      controller: entrada_registro_ContraCuenta,
                      obscureText: true,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password_outlined),
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
                      controller: entrada_registro_TelefonoCuenta,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                        labelText: 'Telefono',
                      ),
                    ),
                  ),
                  const Text("Metodo de pago", style: TextStyle(fontSize: 16),),
                  SizedBox(height: screenheight * 0.02 ,),
                  Row(
                    children: <Widget>[
                      SizedBox(width: screenSize * 0.05),
                      SizedBox(
                        width: screenSize * 0.30,
                        height: screenheight * 0.07,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.credit_card),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,

                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  if(dropdownValue == 'Tarjeta'){
                                    visibilidad1 = true;
                                    visibilidad2 = true;
                                    visibilidad3 = true;
                                    visibilidad4 = true;
                                  }else{
                                    if(dropdownValue == 'Efectivo'){
                                      visibilidad1 = false;
                                      visibilidad2 = false;
                                      visibilidad3 = false;
                                      visibilidad4 = false;
                                    }
                                  }
                                });
                              },
                              items: <String>['Efectivo', 'Tarjeta']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize * 0.02 ),
                      Visibility(
                        visible: visibilidad1,
                        child: SizedBox(
                          width: screenSize * 0.13,
                          height: screenheight * 0.07,
                          child:const TextField(
                            decoration: InputDecoration(
                              labelText: 'DD',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize * 0.02 ),
                      Visibility(
                        visible: visibilidad2,
                        child: SizedBox(
                          width: screenSize * 0.15,
                          height: screenheight * 0.07,
                          child:const TextField(
                            decoration: InputDecoration(
                              labelText: 'MM',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize * 0.02 ),
                      Visibility(
                        visible: visibilidad3,
                        child: SizedBox(
                          width: screenSize * 0.25,
                          height: screenheight * 0.07,
                          child:const TextField(
                            decoration: InputDecoration(
                              labelText: 'AAAA',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight * 0.01,),
                  Visibility(
                    visible: visibilidad4,
                    child: SizedBox(
                      width: screenSize * 0.90,
                      height: screenheight * 0.10,
                      child:const TextField(
                            decoration: InputDecoration(
                          labelText: 'Numero de tarjeta',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenheight * 0.01,),
                  OutlinedButton(

                    onPressed: () async{
                      getvalue = entrada_registro_NombreCuenta.text.toString();
                      getvalue2 = entrada_registro_ApellidoCuenta.text.toString();
                      getvalue3 = entrada_registro_ContraCuenta.text.toString();
                      getvalue4 = entrada_registro_TelefonoCuenta.text.toString();
                      getvalue5 = entrada_registro_NombreCorreo.text.toString();
                      insertarusuario(getvalue5, getvalue, getvalue2, getvalue3, getvalue4);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUserScreen()));
                  
                    },
                    child: const Text('Crear Cuenta', style: TextStyle(color: Colors.white, fontSize: 20)),
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
    );
  }
}
