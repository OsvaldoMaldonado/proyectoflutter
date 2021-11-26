import 'package:flutter/material.dart';
import 'login_employee_screen.dart';
import 'model/modelo_login_cuentas.dart';

//Agregar que reciba la id del empleado
class RegisterEmployeeJobsScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String contra;
  final String rfc;
  final String correo;
  const RegisterEmployeeJobsScreen({Key? key, required this.nombre, required this.apellido, required this.contra, required this.rfc
    , required this.correo}) : super(key: key);


  @override
  RegisterEmployeeJobsState createState() => RegisterEmployeeJobsState(nombre: nombre,apellido: apellido,contra: contra,rfc: rfc,correo: correo);
}

class RegisterEmployeeJobsState extends State<RegisterEmployeeJobsScreen> {
  final String nombre;
  final String apellido;
  final String contra;
  final String rfc;
  final String correo;
   RegisterEmployeeJobsState({Key? key, required this.nombre, required this.apellido, required this.contra, required this.rfc
    , required this.correo});
  Map<String, bool?> lightSwitches = {
    'Electricista': false,
    'Carpintero': false,
    'Cerrajero': false,
    'Coach de futbol': false,
    'Fumigador': false,
    'Limpieza de muebles': false,
    'Mariachi': false,
    'Masajista': false,
    'Mecanica': false,
  };
  int contador1 = 0;
  int contador2 = 0;
  int contador3 = 0;
  int contador4 = 0;
  int contador5 = 0;
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
              children: [
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
                        turns: const AlwaysStoppedAnimation(180 / 360),
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
                  alignment: Alignment.center,
                  child:const Text(
                    'En que te especializas',
                    style: TextStyle(
                        fontSize: 22),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: lightSwitches.keys
                            .map((roomName) => CheckboxListTile(
                          title: Text(roomName),
                          value: lightSwitches[roomName],
                          onChanged: (bool? value) {
                            setState(() {
                              lightSwitches[roomName] = value;
                              if(roomName == "Electricista" && contador1 == 1){
                                contador1 = 0;
                                print("peto90 Electricista");
                              }else{
                                if(roomName == "Carpintero" && contador2 == 1){
                                  contador2 = 0;
                                  print(" peto90 Carpintero");
                                }else{
                                  if(roomName == "Mecanica" && contador3 == 1){
                                    contador3 = 0;
                                    print("peto90 Mecanica");
                                  }else{
                                    if(roomName == "Cerrajero" && contador4 == 1){
                                      contador4 = 1;
                                      print("peto90 cerrajero");
                                    }
                                  }
                                }
                              }
                              if(roomName == "Electricista"){
                                contador1 = 1;
                                print("Electricista");
                              }else{
                                if(roomName == "Carpintero"){
                                  contador2 = 1;
                                  print("Carpintero");
                                }else{
                                  if(roomName == "Mecanica"){
                                    contador3 = 1;
                                    print("Mecanica");
                                  }else{
                                    if(roomName == "Cerrajero"){
                                      contador4 = 1;
                                      print("cerrajero");
                                    }
                                  }
                                }
                              }

                            });
                          },
                        ))
                            .toList(),
                      ),
                    ),
                    flex: 1),
                OutlinedButton(
                  onPressed: () {
                    insertarempleado(correo, nombre, apellido, contra, rfc);
                    print(nombre);
                    if(contador1 == 1){
                      insertarempleadoespecializacion(correo);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginEmployeeScreen()));
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
                SizedBox(height: screenheight * 0.04,),
              ]
          )
      ),
    );
  }

}







