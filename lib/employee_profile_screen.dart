// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:servicios_vic/model/modelo_perfil_cuentas.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/modelo_login_cuentas.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key}) : super(key: key);

  @override
  EmployeeProfileState createState() => EmployeeProfileState();
}


class EmployeeProfileState extends State<EmployeeProfileScreen> {

  String idEmployee = '';

  Future<void> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id') ?? '';

    setState(() => idEmployee = id);
  }

  @override
  Widget build(BuildContext context) {
    if (idEmployee == ''){
      getId();
    }

    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: screenSize,
          child: FutureBuilder<Employee?>(
            future: fetchEmployee(http.Client(), idEmployee),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                //return Text(snapshot.data!.correo);
                return Perfil(perfil: snapshot.data!, idEmployee : idEmployee);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Perfil extends StatefulWidget {

  const Perfil({Key? key, required this.perfil, required this.idEmployee}) : super(key: key);

  final Employee perfil;
  final String idEmployee;

  @override
  // ignore: no_logic_in_create_state
  State<Perfil> createState() => _PerfilState(idEmployee: idEmployee);
}

class _PerfilState extends State<Perfil> {

  _PerfilState({Key? key, required this.idEmployee});

  final String idEmployee;
  var texto = 'Editar';
  var texto2 = 'Editar';
  var texto3 = 'Editar';
  var texto4 = 'Editar';
  int contador1 = 0;
  bool funcionalidad1 = false;
  bool visibilidad1 = true;
  bool visibilidad2 = false;
  bool visibilidad3 = true;
  bool visibilidad4 = false;
  bool visibilidad5 = true;
  bool visibilidad6 = false;
  bool visibilidad7 = true;
  bool visibilidad8 = false;
  String getvalue = "";
  TextEditingController entrada_nombre = TextEditingController();
  TextEditingController entrada_apellido = TextEditingController();
  TextEditingController entrada_correo = TextEditingController();
  TextEditingController entrada_telefono = TextEditingController();
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
                Container(
                  width: screenSize ,
                  height: screenheight * 0.40,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: SizedBox(
                    width: screenSize ,
                    height: screenheight * 0.30,
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
                  top: 35,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0
                    ),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xffe0e0e0)
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(30.0),
                      // ignore: prefer_const_constructors
                      child: Center(
                        child: const Icon(Icons.arrow_back, color: Color(0xfff96332)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage('https://i.pinimg.com/originals/77/9e/1f/779e1f2ea40ccf579f3f7ef94225b287.jpg')
                    ),
                  ),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    visible: visibilidad1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.perfil.nombre + " " + widget.perfil.apellido,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ]
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  <Widget>[
                    Visibility(visible:visibilidad7, child: Text(widget.perfil.telefono, textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),)),
                    Visibility(visible:visibilidad8, child: SizedBox(
                      width: screenSize * 0.70,
                      height: screenheight * 0.07,
                      child: TextField(
                        enabled: visibilidad8,
                        controller: entrada_telefono,
                        decoration: InputDecoration(
                          labelText: '"Telefono >   "',
                        ),
                      ),
                    ),
                    ),
                    InkWell(
                        child: Text(texto4, style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.end,),
                        onTap: () {
                          setState(() {
                            print(contador1);
                            if (contador1 == 0) {
                              visibilidad7 = false;
                              visibilidad8 = true;
                              texto4 = "Guardar";
                              contador1++;
                            } else {
                              if (contador1 == 1) {
                                visibilidad7 = true;
                                texto4 = 'Editar';
                                getvalue = entrada_correo.text.toString();
                                visibilidad8 = false;
                                modificarempleadotelefono(widget.perfil.telefono, getvalue);
                                contador1 = 0;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeProfileScreen()));
                              };
                            }
                          }
                          );

                        }
                    ),
                  ]
              ),
            ),
            SizedBox(height: screenheight * 0.01),
            Container(
              alignment: Alignment.center,
              child: FutureBuilder<String>(
                future: getLocacion(double.parse(widget.perfil.latitud), double.parse(widget.perfil.longitud)),
                builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return
                      Row(
                          mainAxisAlignment:  MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.place, size: 16,),
                            Text(snapshot.data.toString(), style: const TextStyle(fontSize: 16))
                          ]
                      );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                Container( width: screenSize * 0.26,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                ),
                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star,
                    color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star,
                    color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star,
                    color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star_half,
                    color: Colors.amber,),
                ),

                Container( width: screenSize * 0.10,
                  height: screenheight * 0.10,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.star_border_outlined,
                    color: Colors.amber,),
                ),
                SizedBox(width: screenSize * 0.03 ),
              ],
            ),
            Stack(
              children: <Widget>[
                Container( width: screenSize ,
                  height: screenheight * 0.18,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )
                      )
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Resenas>?>(   
                future: fetchEmployeeReviews(http.Client(), idEmployee),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return EmpleadoReviewsList(resenasEmpleado: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

          ],
        ),


        // floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        // tooltip: 'Increment',
        // child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}



class EmpleadoReviewsList extends StatelessWidget {
  const EmpleadoReviewsList({Key? key,required this.resenasEmpleado});


  final List<Resenas> resenasEmpleado;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: resenasEmpleado.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(
              left: screenSize * 0.05,
              right: screenSize * 0.05,
              bottom: 10.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(resenasEmpleado[index].nombre + " " + resenasEmpleado[index].apellido, style: const TextStyle(fontSize: 14)),
                  Text (resenasEmpleado[index].fecha_aceptacion, style: const TextStyle(fontSize: 14)),
                ],
              ),
              calificacion(resenasEmpleado[index].valoracion),
              Text(resenasEmpleado[index].resena, style: const TextStyle(fontSize: 12), textAlign: TextAlign.start,),
              const Divider(color: Color(0xFFF96332),thickness: 0.5),           
            ],
          )
        );    
      },
    );
  }

  Widget calificacion (String cantidad){
    double cantidadNumerica = 6; 
    try{
      cantidadNumerica = double.parse(cantidad);
    }catch(e){
      return const Text(" ");
    }
    if(cantidadNumerica < 1.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else if(cantidadNumerica < 2.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else if(cantidadNumerica < 3.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else if(cantidadNumerica < 4.1){
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star_outline, color: Colors.yellow, size: 12,),
        ]
      );
    }
    else {
      return Row(
        children: const <Widget>[
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
          Icon(Icons.star, color: Colors.yellow, size: 12,),
        ]
      );
    }
  }
}