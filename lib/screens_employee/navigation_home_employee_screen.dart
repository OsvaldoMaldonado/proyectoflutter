// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servicios_vic/home_screen.dart';
import 'package:servicios_vic/screens_employee/configurations_employee_screen.dart';
import 'package:servicios_vic/screens_employee/employee_profile_screen.dart';
import 'package:servicios_vic/screens_employee/finances_employee_screen.dart';
import 'package:servicios_vic/screens_employee/maps_employee_jobs_location_screen.dart';
import 'package:servicios_vic/model/colors.dart';
import 'package:servicios_vic/model/modelo_navegacion_empleado.dart';
import 'package:servicios_vic/screens_employee/services_employee_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NavigationHomeEmployeeScreen extends StatefulWidget {
  const NavigationHomeEmployeeScreen({Key? key}) : super(key: key);

  @override
  NavigationHomeEmployeeState createState() => NavigationHomeEmployeeState();
}

class NavigationHomeEmployeeState extends State<NavigationHomeEmployeeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  String _title = 'Bienvenido a Servicios Vic';
  String _color = 'F1F0F5';

  var appBarTitleText = Text("Bienvenido a Servicios Vic");
  static const List<Widget> _widgetOptions = <Widget>[
    NavigationHomeEmployeeScreenTab(),
    EmployeeProfileScreen(),
    ServicesEmployeeScreen(),
    FinancesEmployeeScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        switch (index) {
          case 0:
            {
              _title = 'Bienvenido a Servicios Vic';
              _color = 'F1F0F5';
            }
            break;
          case 1:
            {
              _title = '';
              _color = 'F96332';
            }
            break;
          case 2:
            {
              _title = 'Historial de servicios';
              _color = 'F1F0F5';
            }
            break;
          case 3:
            {
              _title = 'Finanzas';
              _color = 'F1F0F5';
            }
            break;
        }
      });
    }

    @override
    initState() {
      _title = 'Bienvenido a Servicios Vic';
      _color = 'F1F0F5';
    }

    return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          backgroundColor: HexColor(_color),
          elevation: 0,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black38,
          title: Text(
            _title,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ConfigurationEmployeeScreen()),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFF96332),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25.0, color: Color(0xFFF96332)),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.person_pin, size: 25.0, color: Color(0xFFF96332)),
              label: 'Mi cuenta',
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.access_time, size: 25.0, color: Color(0xFFF96332)),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on,
                  size: 25.0, color: Color(0xFFF96332)),
              label: 'Finanzas',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ),
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}

class NavigationHomeEmployeeScreenTab extends StatefulWidget {
  const NavigationHomeEmployeeScreenTab({Key? key}) : super(key: key);

  @override
  NavigationHomeEmployeeTabState createState() =>
      NavigationHomeEmployeeTabState();
}

class NavigationHomeEmployeeTabState
    extends State<NavigationHomeEmployeeScreenTab> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String locacion = "";
  double latitud = 0.0, longitud = 0.0;
  String idEmployee = '';

  Future<void> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id') ?? '';

    setState(() => idEmployee = id);
  }

  final List<String> imageList = [
    "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    if (idEmployee == '') {
      getId();
    }
    double screenSize = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
      color: Color(0xFFF1F0F5),
      child: Column(
        children: <Widget>[
          SizedBox(height: screenHeight * 0.01),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                aspectRatio: 5.0,
              ),
              itemBuilder: (context, i, id) {
                //for onTap to redirect to another screen
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    //ClipRRect for image border radius
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imageList[i],
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    var url = imageList[i];
                  },
                );
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: screenSize * 0.05),
            child: const Text(
              'Trabajos activos',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Expanded(
            child: FutureBuilder<List<TrabajosEmpleado>?>(
              future:
                  fetchTrabajosEmpleado(http.Client(), idEmployee, "activo"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ningun Resultado!'),
                  );
                } else if (snapshot.hasData) {
                  return TrabajosEmpleadoList(trabajosEmpleado: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFF96332))),
                  );
                }
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: FutureBuilder<List<TrabajosEmpleado>?>(
              future: fetchTrabajosEmpleado(
                  http.Client(), idEmployee, "pendienteCosto"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center();
                } else if (snapshot.hasData) {
                  return TrabajosPendientesCostoEmpleadoList(
                      trabajosEmpleado: snapshot.data!);
                } else {
                  return Text("");
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class TrabajosPendientesCostoEmpleadoList extends StatefulWidget {
  const TrabajosPendientesCostoEmpleadoList(
      {Key? key, required this.trabajosEmpleado})
      : super(key: key);
  final List<TrabajosEmpleado> trabajosEmpleado;

  @override
  // ignore: no_logic_in_create_state
  TrabajosPendientesCostoEmpleadoListState createState() =>
      TrabajosPendientesCostoEmpleadoListState(
          trabajosEmpleado: trabajosEmpleado);
}

class TrabajosPendientesCostoEmpleadoListState
    extends State<TrabajosPendientesCostoEmpleadoList> {
  TrabajosPendientesCostoEmpleadoListState(
      {Key? key, required this.trabajosEmpleado});

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
            margin: EdgeInsets.only(bottom: 10.0, left: screenSize * 0.07),
            padding: EdgeInsets.only(bottom: 10.0, top: 7),
            decoration: BoxDecoration(
              color: Color(0xDDffe147),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            child: Container(
              margin: EdgeInsets.only(
                  left: screenSize * 0.05,
                  right: screenSize * 0.05,
                  bottom: 10.0,
                  top: 10.0),
              child: RichText(
                  text: TextSpan(
                text: "Tienes un trabajo de " +
                    trabajosEmpleado[index].nombreS +
                    " pendiente de pago con " +
                    trabajosEmpleado[index].nombre +
                    " " +
                    trabajosEmpleado[index].apellido +
                    ", ",
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                children: [
                  TextSpan(
                    text: "¡Rcuerdale!",
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )),
            ));
      },
    );
  }
}

class TrabajosEmpleadoList extends StatefulWidget {
  const TrabajosEmpleadoList({Key? key, required this.trabajosEmpleado})
      : super(key: key);
  final List<TrabajosEmpleado> trabajosEmpleado;

  @override
  // ignore: no_logic_in_create_state
  TrabajosEmpleadoListState createState() =>
      TrabajosEmpleadoListState(trabajosEmpleado: trabajosEmpleado);
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
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: 10.0, right: screenSize * 0.07),
            padding: EdgeInsets.only(bottom: 7.0, top: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                          latitud: trabajosEmpleado[index].latitud,
                          longitud: trabajosEmpleado[index].longitud,
                          trabajoId: trabajosEmpleado[index].id)),
                );
              },
              child: Container(
                  margin: EdgeInsets.only(
                      left: screenSize * 0.05,
                      right: screenSize * 0.05,
                      bottom: 10.0,
                      top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                          IconData(int.parse(trabajosEmpleado[index].icono)),
                          size: 50.0,
                          color: HexColor(trabajosEmpleado[index].color)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Text(
                              trabajosEmpleado[index].nombreS,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: Text(
                              trabajosEmpleado[index].nombre +
                                  " " +
                                  trabajosEmpleado[index].apellido,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ));
      },
    );
  }
}
