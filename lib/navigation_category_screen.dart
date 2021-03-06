// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servicios_vic/navitagion_job_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:servicios_vic/model/modelo_navegacion_usuario.dart';
import 'navigation_home_screen.dart';

class NavigationCategoryScreen extends StatefulWidget{

  String? profesion;
  int? id_profesion;

  NavigationCategoryScreen({Key? key, required this.profesion, required this.id_profesion}) : super(key: key);
  
  @override
  // ignore: no_logic_in_create_state
  NavigationCategoryState createState() => NavigationCategoryState(id_profesion: id_profesion, profesion: profesion);
}


class NavigationCategoryState extends State<NavigationCategoryScreen> {
  NavigationCategoryState({Key? key, required this.profesion, required this.id_profesion});

  String busqueda = "";

  Future<void> setBuscador(String textoBuscador) async {
    //print(textoBuscador);
    setState(() => busqueda = textoBuscador);
  }

  String? profesion;
  int? id_profesion;
 
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('¿Que categoria estas buscando?', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
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
                hintText: 'Buscar categorias',
                fillColor: Color(0xffe0e0e0), filled: true,
                hintStyle: TextStyle(color: Colors.black),
              ),
                
            )
          ),
          SizedBox(height: screenheight * 0.01),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text('Profesion > $profesion', 
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: screenheight * 0.01),
          Container(
            alignment: Alignment.topLeft,  
            width: screenSize * 0.90,
            child: FutureBuilder<List<TipoServicio>?>(
              future: fetchTipoServicio(http.Client(), id_profesion!, busqueda),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return TipoServicioList(tiposervicio: snapshot.data!, profesion: profesion, id_profesion: id_profesion);
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
    );
  }

}
class TipoServicioList extends StatelessWidget {

  final String? profesion;
  final int? id_profesion;
  final List<TipoServicio> tiposervicio;
  const TipoServicioList({Key? key, required this.tiposervicio, this.profesion, this.id_profesion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    //double screenSheght = MediaQuery.of(context).size.height;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3.5
      ),
      itemCount: tiposervicio.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(
              left: 6.0,
              right: 6.0,
              bottom: 15.0
            ),
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
                MaterialPageRoute(builder: (context) => NavigationJobScreen(tiposervicio: tiposervicio[index].nombre, 
                id_tiposervicio: int.parse(tiposervicio[index].id), profesion: profesion, id_profesion: id_profesion,)),
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
                  child: Text( tiposervicio[index].nombre, 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ), 
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 16.0,
                  ),
                  child: Text( tiposervicio[index].descripcion, 
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
                  child: const Text( 'Categoria', 
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