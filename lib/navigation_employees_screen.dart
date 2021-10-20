// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:servicios_vic/model/modelo_navegacion_usuario.dart';

import 'navigation_confirm_job_screen.dart';

class NavigationEmployeesScreen extends StatefulWidget{

  final String? profesion;
  final int? id_profesion;
  final String? tiposervicio;
  final int? id_tiposervicio;
  final String? servicio;
  final int? id_servicio;

  const NavigationEmployeesScreen({Key? key, required this.tiposervicio, required this.id_tiposervicio, this.profesion, this.id_profesion, this.servicio, this.id_servicio}) : super(key: key);
  
  @override
  // ignore: no_logic_in_create_state
  NavigationEmployeesState createState() => NavigationEmployeesState(id_tiposervicio: id_tiposervicio, tiposervicio: tiposervicio, id_profesion: id_profesion, id_servicio: id_servicio, profesion: profesion, servicio: servicio);
}


class NavigationEmployeesState extends State<NavigationEmployeesScreen> {
  NavigationEmployeesState({Key? key, required this.tiposervicio, required this.id_tiposervicio, required this.profesion, required this.id_profesion, required this.id_servicio, required this.servicio});

  String busqueda = "";
  double latitud = 0.0, longitud = 0.0;

  Future<void> setBuscador(String textoBuscador) async {
    //print(textoBuscador);
    setState(() => busqueda = textoBuscador);
  }

  final String? profesion;
  final int? id_profesion;
  final String? tiposervicio;
  final int? id_tiposervicio;
  final String? servicio;
  final int? id_servicio;


  void _getCurrentLocation() async {
    LocationPermission permission;
    
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          latitud = 0.0;
        });
      }else{
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          latitud = position.latitude;
          longitud = position.longitude;
        });
      }
    }else{
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
          latitud = position.latitude;
          longitud = position.longitude;
      });
    }
  }
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Prestadores Disponibles', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: screenheight * 0.01),
          Container(
            alignment: Alignment.topLeft,
            width: screenSize * 0.90,
            child: TextField(
              onSubmitted: (textoBuscador){
                setBuscador(textoBuscador);
              },
              decoration: const InputDecoration(    
                focusColor: Colors.grey,  
                hintText: 'Buscar prestador',
                fillColor: Color(0xffe0e0e0), filled: true,
                hintStyle: TextStyle(color: Colors.black),
              ),  
            )
          ),
          SizedBox(height: screenheight * 0.01),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Profesion > $profesion > $tiposervicio > $servicio', 
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: screenheight * 0.01),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top:20.0,left: 12.0, right: 12.0),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[    
                Container(
                  alignment: Alignment.topLeft,  
                  width: screenSize * 0.90,
                  child: FutureBuilder<List<Empleados>?>(
                    future: fetchEmpleados(http.Client(), busqueda, id_servicio!, latitud, longitud),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Ningun Resultado!'),
                        );
                      } else if (snapshot.hasData) {
                        return EmpleadosList(empleados: snapshot.data!, servicio: servicio, id_servicio: id_servicio);
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
          ),
        ],
      ),
    );
  }
}

class EmpleadosList extends StatelessWidget {

  final List<Empleados> empleados;
  final String? servicio;
  final int? id_servicio;

  const EmpleadosList({Key? key, required this.empleados, required this.servicio, required this.id_servicio}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3.5
      ),
      itemCount: empleados.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(
              left: 6.0,
              right: 6.0,
              bottom: 15.0
            ),
            height: screenSize * .22,
            width: screenSize * .90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
               ),
              ],
            ),
          child: InkWell( 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationConfirmJobScreen(servicio:servicio, id_servicio:id_servicio, id_prestador: empleados[index].id, prestador: empleados[index].nombre + " " + empleados[index].apellido)),
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            // ignore: prefer_const_constructors
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    left: 15.0,
                  ),
                  child: Text(empleados[index].nombre + " " + empleados[index].apellido,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ), 
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text("Numero telefonico: " + empleados[index].telefono, 
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ), 
                  ),
                ),
                Container(
                  width: screenSize * .20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xfff96332),
                  ),
                  margin: EdgeInsets.only(
                    left: screenSize * .63,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Text( 'Prestador', 
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ), 
                  ),
                ),
              ]
            ),
          ),
          
        );    
      },
    );
  }
}