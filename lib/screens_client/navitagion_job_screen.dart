// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:servicios_vic/model/modelo_navegacion_usuario.dart';
import 'package:servicios_vic/screens_client/navigation_employees_screen.dart';

class NavigationJobScreen extends StatefulWidget {
  final String profesion;
  final int id_profesion;
  final String tiposervicio;
  final int id_tiposervicio;

  const NavigationJobScreen(
      {Key? key,
      required this.tiposervicio,
      required this.id_tiposervicio,
      required this.profesion,
      required this.id_profesion})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  NavigationJobState createState() => NavigationJobState(
      id_profesion: id_profesion,
      profesion: profesion,
      id_tiposervicio: id_tiposervicio,
      tiposervicio: tiposervicio);
}

class NavigationJobState extends State<NavigationJobScreen> {
  NavigationJobState(
      {Key? key,
      required this.tiposervicio,
      required this.id_tiposervicio,
      required this.profesion,
      required this.id_profesion});

  String busqueda = "";

  Future<void> setBuscador(String textoBuscador) async {
    //print(textoBuscador);
    setState(() => busqueda = textoBuscador);
  }

  final String profesion;
  final int id_profesion;
  final String tiposervicio;
  final int id_tiposervicio;

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFF1F0F5),
            elevation: 0,
            shadowColor: Colors.transparent,
            foregroundColor: const Color(0xFFF96332),
            title: const Text(
              '¿Que trabajo estas buscando?',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            )),
        body: Container(
          color: Color(0xFFF1F0F5),
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.01),
              Container(
                  alignment: Alignment.topLeft,
                  width: screenSize * 0.90,
                  child: TextField(
                    onSubmitted: (textoBuscador) {
                      setBuscador(textoBuscador);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Buscar trabajos...',
                      labelText: 'Buscar trabajos...',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                  )),
              SizedBox(height: screenHeight * 0.01),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 10.0, left: 20.0),
                child: Text(
                  '$profesion > $tiposervicio',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                alignment: Alignment.topCenter,
                margin:
                    const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      width: screenSize * 0.90,
                      child: FutureBuilder<List<Servicio>?>(
                        future: fetchServicio(
                            http.Client(), id_tiposervicio, busqueda),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Ningun Resultado!'),
                            );
                          } else if (snapshot.hasData) {
                            return ServicioList(
                                servicio: snapshot.data!,
                                profesion: profesion,
                                id_profesion: id_profesion,
                                tiposervicio: tiposervicio,
                                id_tiposervicio: id_tiposervicio);
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFF96332))),
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
        ));
  }
}

class ServicioList extends StatelessWidget {
  final String profesion;
  final int id_profesion;
  final String tiposervicio;
  final int id_tiposervicio;

  final List<Servicio> servicio;
  const ServicioList(
      {Key? key,
      required this.servicio,
      required this.profesion,
      required this.id_profesion,
      required this.tiposervicio,
      required this.id_tiposervicio})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: servicio.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(right: 10, top: 7, bottom: 15.0),
          margin: const EdgeInsets.only(left: 6.0, right: 6.0, bottom: 15.0),
          width: screenSize * .90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NavigationEmployeesScreen(
                        profesion: profesion,
                        id_profesion: id_profesion,
                        tiposervicio: tiposervicio,
                        id_tiposervicio: id_tiposervicio,
                        id_servicio: int.parse(servicio[index].id),
                        servicio: servicio[index].nombre)),
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
                    child: Text(
                      servicio[index].nombre,
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
                    child: Text(
                      servicio[index].descripcion,
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
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      'Trabajo',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }
}
