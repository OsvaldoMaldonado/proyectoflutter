import 'package:flutter/material.dart';


//Agregar que reciba la id del empleado
class RegisterEmployeeJobsScreen extends StatefulWidget {
  const RegisterEmployeeJobsScreen({Key? key}) : super(key: key);


  @override
  RegisterEmployeeJobsState createState() => RegisterEmployeeJobsState();
}

class RegisterEmployeeJobsState extends State<RegisterEmployeeJobsScreen> {
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
                          });
                        },
                      ))
                          .toList(),
                    ),
                  ),
                  flex: 1),
              OutlinedButton(
                onPressed: () {
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




