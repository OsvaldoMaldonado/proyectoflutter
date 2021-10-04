import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/login_usuario.dart';
import 'modelo.dart';
class registro extends StatefulWidget {
  final String title;

  registro({this.title = 'Demo'});

  @override
  registranding createState() => registranding();
}
class registranding extends State<registro> {

  TextEditingController entrada_registro_NombreCorreo = TextEditingController();
  TextEditingController entrada_registro_NombreCuenta = TextEditingController();
  TextEditingController entrada_registro_ApellidoCuenta = TextEditingController();
  TextEditingController entrada_registro_ContraCuenta = TextEditingController();
  TextEditingController entrada_registro_RFCCuenta = TextEditingController();
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
                      height: screenheight * 0.10,
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
                      child: SizedBox(
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
                  '  Crear Cuenta',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 25),
                ),
              ),
              SizedBox(height: screenheight * 0.03,),
              SizedBox(
                  width: screenSize * 0.90,
                  height: screenheight * 0.10,
                  child:TextField(
                    controller: entrada_registro_NombreCorreo,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                        fillColor: Color(0xFFe0e0e0), filled: true,
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

                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                        fillColor: Color(0xFFe0e0e0), filled: true,
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
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                        fillColor: Color(0xFFe0e0e0), filled: true,
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
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                    fillColor: Color(0xFFe0e0e0), filled: true,
                    labelText: 'Contraseña',
                  ),
                ),
              ),
    
              SizedBox(
                width: screenSize * 0.90,
                height: screenheight * 0.10,
                child:TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                    fillColor: Color(0xFFe0e0e0), filled: true,
                    labelText: 'Vuelva a escribir la contraseña',
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Spacer(),

                  SizedBox(
                    width: screenSize * 0.90,
                    height: screenheight * 0.10,

                    child:TextField(
                      controller: entrada_registro_RFCCuenta,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                        fillColor: Color(0xFFe0e0e0), filled: true,
                        labelText: 'RFC',
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize * 0.05 ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: screenSize * 0.05),
                  SizedBox(
                    width: screenSize * 0.30,
                    height: screenheight * 0.07,
                    child: InputDecorator(
                      decoration:  InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color:  Color(0xFFe0e0e0), width: 2.0), ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        fillColor: Color(0xFFe0e0e0), filled: true,
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
                      child:TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                          fillColor: Color(0xFFe0e0e0), filled: true,
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
                      child:TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                          fillColor: Color(0xFFe0e0e0), filled: true,
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
                      child:TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                          fillColor: Color(0xFFe0e0e0), filled: true,
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
                  child:TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Color(0xFFe0e0e0), width: 2.0),),
                      fillColor: Color(0xFFe0e0e0), filled: true,
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
                  getvalue4 = entrada_registro_RFCCuenta.text.toString();
                  getvalue5 = entrada_registro_NombreCorreo.text.toString();
                  insertarusuario(getvalue5, getvalue, getvalue2, getvalue3, getvalue4);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => login_usuario()));
              
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

    );
  }
}
