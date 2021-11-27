// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/employee_profile_screen.dart';
import 'package:servicios_vic/finances_employee_screen.dart';
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/maps_employee_jobs_location_screen.dart';
import 'package:servicios_vic/model/modelo_navegacion_empleado.dart';
import 'package:servicios_vic/services_employee_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/modelo_perfil_cuentas.dart';

class NavigationHomeEmployeeScreen extends StatefulWidget{
   const NavigationHomeEmployeeScreen({Key? key}) : super(key: key);

  @override
  NavigationHomeEmployeeState createState() => NavigationHomeEmployeeState();
}


class NavigationHomeEmployeeState extends State<NavigationHomeEmployeeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String locacion = "";
  double latitud = 0.0, longitud = 0.0;
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
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
            accountName: FutureBuilder<Employee?>(   
              future: fetchEmployee(http.Client(), idEmployee),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('An error has occurred!');
                } else if (snapshot.hasData) {
                  return Text(snapshot.data!.nombre + " " + snapshot.data!.apellido ,style: const TextStyle(fontSize: 14.0,color: Colors.black,),);
                  //return Text(snapshot.data!.correo);
                } else {
                  return LinearProgressIndicator(minHeight: 4,);
                }
              },
            ),
            accountEmail: FutureBuilder<Employee?>(   
              future: fetchEmployee(http.Client(), idEmployee),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('An error has occurred!');
                } else if (snapshot.hasData) {
                  return Text(snapshot.data!.correo ,style: const TextStyle(fontSize: 14.0,color: Colors.black,),);
                  //return Text(snapshot.data!.correo);
                } else {
                  return LinearProgressIndicator(minHeight: 4,);
                }
              },
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF96332),
                  Color(0xFFFF6365),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/46.jpg")),
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  SizedBox(width: 7.0,),
                  Icon(Icons.person_pin, size: 30.0, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('Mi cuenta',style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                  )
                ],
              ),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const EmployeeProfileScreen()));
              } ,
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  SizedBox(width: 7.0,),
                  Icon(Icons.access_time,size: 30.0, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('Historial de servicios',style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                  )
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ServicesEmployeeScreen()));  
              } ,
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  SizedBox(width: 7.0,),
                  Icon(Icons.money,size: 30.0, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('Finanzas',style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                  )
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FinancesEmployeeScreen()));  
              } ,
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  SizedBox(width: 7.0,),
                  Icon(Icons.logout, size: 30.0, color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('Cerrar Sesión',style: TextStyle(fontSize: 18.0, color: Colors.black54),),
                  )
                ],
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('id');
                prefs.remove('type');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => const HomeScreen()));
              },
            ),
          ],
        ),
      ), 
      body: Container(
        color :  Color(0xFFF1F0F5),
        child: Column(
          children: <Widget>[
            SizedBox(height: screenheight * 0.01),
            Expanded(
              child: FutureBuilder<List<TrabajosEmpleado>?>(
                future: fetchTrabajosEmpleado(http.Client(), idEmployee, "activo"),
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
            SizedBox(height: screenheight * 0.01),
            Expanded(
              child: FutureBuilder<List<TrabajosEmpleado>?>(
                future: fetchTrabajosEmpleado(http.Client(), idEmployee, "pendienteCosto"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                    );
                  } else if (snapshot.hasData) {
                    return TrabajosPendientesCostoEmpleadoList(trabajosEmpleado: snapshot.data!);
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
    );
  }
}


class TrabajosPendientesCostoEmpleadoList extends StatefulWidget{
  const TrabajosPendientesCostoEmpleadoList({Key? key,required this.trabajosEmpleado}) : super(key: key);
  final List<TrabajosEmpleado> trabajosEmpleado;

  @override
  // ignore: no_logic_in_create_state
  TrabajosPendientesCostoEmpleadoListState createState() => TrabajosPendientesCostoEmpleadoListState(trabajosEmpleado: trabajosEmpleado);
}


class TrabajosPendientesCostoEmpleadoListState extends State<TrabajosPendientesCostoEmpleadoList> {
  TrabajosPendientesCostoEmpleadoListState({Key? key,required this.trabajosEmpleado});

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
          margin: const EdgeInsets.only(
              bottom: 5.0
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
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
                        Text("Tienes un trabajo de " + trabajosEmpleado[index].nombreS + " pendiente con " + trabajosEmpleado[index].nombre + " " + trabajosEmpleado[index].apellido + "\n !Recuerdale!", 
                        textAlign: TextAlign.left,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              ),       
            ),
        );    
      },
    );
  }
}


class TrabajosEmpleadoList extends StatefulWidget{
  const TrabajosEmpleadoList({Key? key,required this.trabajosEmpleado}) : super(key: key);
  final List<TrabajosEmpleado> trabajosEmpleado;

  @override
  // ignore: no_logic_in_create_state
  TrabajosEmpleadoListState createState() => TrabajosEmpleadoListState(trabajosEmpleado: trabajosEmpleado);
}


class TrabajosEmpleadoListState extends State<TrabajosEmpleadoList> {
  TrabajosEmpleadoListState({Key? key,required this.trabajosEmpleado});

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
          margin: const EdgeInsets.only(
              bottom: 5.0
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
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
                        Text(trabajosEmpleado[index].nombreS, textAlign: TextAlign.left,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(flex: 1, child: Text("Fecha", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),                            
                        Expanded(flex: 3, child: Text(trabajosEmpleado[index].fecha_publicacion, style: const TextStyle(fontSize: 15))) 
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: FutureBuilder<String>(   
                      future: getLocacion(double.parse(trabajosEmpleado[index].latitud), double.parse(trabajosEmpleado[index].longitud)),
                      builder: (context, snapshot){
                        if (snapshot.hasError) {
                          return Container(
                            child: Text('An error has occurred!'),
                          );
                        } else if (snapshot.hasData) {
                          return Row (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget> [ 
                              Expanded(flex: 1, child: Text("Ubicación", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),                            
                              Expanded(flex: 3, child: Text(snapshot.data.toString(), style: const TextStyle(fontSize: 15)))
                          ]);
                        } else {
                          return Container(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(flex: 1, child: Text("Nombre del Cliente", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),                            
                        Expanded(flex: 3, child: Text(trabajosEmpleado[index].nombre + " " + trabajosEmpleado[index].apellido, textAlign: TextAlign.left,style: TextStyle(fontSize: 15),)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: Text("Numero Telefonico", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),                            
                        Expanded(flex: 3, child: Text(trabajosEmpleado[index].telefono, textAlign: TextAlign.left,style: TextStyle(fontSize: 15),)),
                      ],
                    ),
                  ),
                  OutlinedButton(
                     onPressed: (){
                       Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => MyHomePage(latitud:trabajosEmpleado[index].latitud, longitud:trabajosEmpleado[index].longitud, trabajoId :trabajosEmpleado[index].id)),
                       );
                     },
                     child: const Text('Ver Detalles', style: TextStyle(color: Colors.white, fontSize: 14)),
                       style: OutlinedButton.styleFrom(
                           shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(5)),
                         side: const BorderSide( width: 0.5, color: Color(0xFFF96332),),
                           //  padding: EdgeInsets.all(60),
                         minimumSize: Size(screenSize * 0.92, screenHeight * 0.045),
                         backgroundColor: const Color(0xFFF96332),
                       ),
                  ),
                ],
              ),       
            ),
        );    
      },
    );
  }
}