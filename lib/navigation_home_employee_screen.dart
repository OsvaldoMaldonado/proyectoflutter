import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/modelo.dart';
import 'package:servicios_vic/services_employee_screen.dart';
import 'package:servicios_vic/user_profile_screen.dart';
import 'package:servicios_vic/employee_profile_screen.dart';
import 'model/colors.dart';
import 'navigation_category_screen.dart';

Future<List<Categorias>?> fetchCategorias(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://proyectonunoxd.000webhostapp.com/categoriashome.php'));

  return compute(parseCategorias, response.body);

}

// A function that converts a response body into a List<Categorias>.
List<Categorias> parseCategorias(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Categorias>((json) => Categorias.fromJson(json)).toList();
}

class Categorias {
  final String id;
  final String nombre;
  final String color;
  final String icono;

  const Categorias({
    required this.id,
    required this.nombre,
    required this.color,
    required this.icono,
  });

  factory Categorias.fromJson(Map<String, dynamic> json) {
    return Categorias(
      id: json['idTab_Categoria'] as String,
      nombre: json['nombre'] as String,
      color: json['color'] as String,
      icono: json['icono'] as String,
    );
  }
}


class NavigationEmployeeScreen extends StatelessWidget {
  final Future<String?> id_usuario;
  NavigationEmployeeScreen({Key? key, required this.id_usuario}) : super(key: key);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.

          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF96332),
                    Color(0xFFFF6365),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text(""),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EmployeeProfileScreen(id_usuario: id_usuario)));
                        },
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.person_pin, size: 30.0,),
                            Text('Mi cuenta',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServicesEmployeeScreen(id_usuario: id_usuario)));
                      },
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.access_time,size: 30.0),
                            Text('Mi Historial de servicios',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                    child: InkWell(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.location_on,size: 30.0),
                            Text('Mis ubicaciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                    child: InkWell(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.credit_card, size: 30.0),
                            Text('Mis metodos de pago',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                    child: InkWell(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.account_balance, size: 30.0),
                            Text('Terminos y condiciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                    child: InkWell(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.help, size: 30.0),
                            Text('Ayuda',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
                Container(height: screenheight*.40,),
                Container(
                    margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                    child: InkWell(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.logout, size: 30.0),
                            Text('Cerrar Sesión',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                          ],
                        )
                    )
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          // TOP HEADER
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 45.0),
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                // ignore: prefer_const_constructors
                Container(
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
                      _globalKey.currentState!.openDrawer();

                    },
                    borderRadius: BorderRadius.circular(30.0),
                    // ignore: prefer_const_constructors
                    child: Center(
                      child: const Icon(Icons.menu, color: Color(0xfff96332)),
                    ),
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