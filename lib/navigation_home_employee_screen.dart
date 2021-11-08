// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/employee_profile_screen.dart';
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/maps_employee_jobs_location_screen.dart';
import 'package:servicios_vic/model/modelo_navegacion_empleado.dart';
import 'package:servicios_vic/serivce_time_employee_screen.dart';
import 'package:servicios_vic/services_employee_screen.dart';
import 'package:servicios_vic/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationHomeEmployeeScreen extends StatefulWidget{
   const NavigationHomeEmployeeScreen({Key? key}) : super(key: key);

  @override
  NavigationHomeEmployeeState createState() => NavigationHomeEmployeeState();
}


class NavigationHomeEmployeeState extends State<NavigationHomeEmployeeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String locacion = "";
  String id = '3';
  double latitud = 0.0, longitud = 0.0;

  void _getiD() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String idUser = prefs.getString('id') ?? '';

      setState(() => id = idUser);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (id == ''){
      _getiD();
    }
    double screenSize = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        foregroundColor: const Color(0xFFF96332),
        title: const Text('Trabajos activos', style: TextStyle(fontSize: 20.0,color: Colors.black,),)
      ),
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
                child: const Text(""),
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
                        MaterialPageRoute(builder: (context) => const EmployeeProfileScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.person_pin, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Mi cuenta',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServicesEmployeeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.access_time,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Historial de servicios',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ServiceTimeEmployeeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.time_to_leave,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Configuración de Diponibilidad',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.location_on,size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Ubicaciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.account_balance, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Terminos y condiciones',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 12.0),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.help, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Ayuda',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
                      ],
                    )
                  )
                ),
                Container(height: screenheight*.40,),
                Container(
                  margin: const EdgeInsets.only(left: 12.0,top: 6.0),
                  child: InkWell(
                    onTap: () async {
                       SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('id');
                        prefs.remove('type');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => const HomeScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.logout, size: 30.0),
                        SizedBox(width: screenSize*0.02,),
                        const Text('Cerrar Sesión',style: TextStyle(fontSize: 18.0,color: Colors.black,),),
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
          SizedBox(height: screenheight * 0.01),
          Expanded(
            child: FutureBuilder<List<TrabajosEmpleado>?>(
              future: fetchTrabajosEmpleado(http.Client(), int.parse(id)),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return TrabajosEmpleadoList(trabajosEmpleado: snapshot.data!);
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

class TrabajosEmpleadoList extends StatefulWidget{
  const TrabajosEmpleadoList({Key? key, required this.trabajosEmpleado}) : super(key: key);
  final List<TrabajosEmpleado> trabajosEmpleado;

  @override
  // ignore: no_logic_in_create_state
  TrabajosEmpleadoListState createState() => TrabajosEmpleadoListState(trabajosEmpleado: trabajosEmpleado);
}


class TrabajosEmpleadoListState extends State<TrabajosEmpleadoList> {
  TrabajosEmpleadoListState({Key? key, required this.trabajosEmpleado});

  var locacion = "";

  final List<TrabajosEmpleado> trabajosEmpleado;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: trabajosEmpleado.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              left: screenSize * 0.05,
              right: screenSize * 0.05,
              bottom: 10.0
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
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
                MaterialPageRoute(builder: (context) => MyHomePage(latitud:trabajosEmpleado[index].latitud, longitud:trabajosEmpleado[index].longitud)),
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            // ignore: prefer_const_constructors
            child: Container(
              margin: EdgeInsets.only(
                  left: screenSize * 0.05,
                  right: screenSize * 0.05,
                  bottom: 10.0,
                  top: 10.0
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Estado > " + trabajosEmpleado[index].estado_servicio, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Fecha de publicación > " + trabajosEmpleado[index].fecha_publicacion, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Ubicación > " + trabajosEmpleado[index].latitud + ", " +  trabajosEmpleado[index].longitud, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Descripcion > " + trabajosEmpleado[index].descripcion, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Usuario > " + trabajosEmpleado[index].nombre + " " + trabajosEmpleado[index].apellido, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Telefono > " + trabajosEmpleado[index].telefono, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Row(
                      children: <Widget>[
                        Text("Servicio > " + trabajosEmpleado[index].nombreS, textAlign: TextAlign.left,style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                ],
              ),       
            ),
          ),   
        );    
      },
    );
  }
}